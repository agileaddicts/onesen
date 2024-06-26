defmodule OnesenWeb.Live.NotebookLive.Show do
  use OnesenWeb, :live_view

  alias Onesen.Models.Notebook
  alias Onesen.Models.Page

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"identifier" => identifier}, _, socket) do
    notebook = Notebook.get!(identifier)

    page =
      case Page.get_today(notebook) do
        nil -> Page.create!(notebook)
        page -> page
      end

    {:noreply,
     socket
     |> assign(:page_title, notebook.name || "Your notebook")
     |> assign(:notebook, notebook)
     |> assign(:page, page)
     |> assign(:zen_mode, false)
     |> assign_new(:random_page, fn -> Page.get_random_not_today(notebook) end)}
  end

  @impl true
  def handle_event("update-notebook-name", %{"name" => name}, socket) do
    notebook = Notebook.update_name!(socket.assigns.notebook, name)

    {:noreply, socket |> assign(notebook: notebook)}
  end

  @impl true
  def handle_event("save-notebook-name", %{"name" => name}, socket) do
    notebook = Notebook.update_name!(socket.assigns.notebook, name)

    {:noreply, socket |> assign(notebook: notebook)}
  end

  @impl true
  def handle_event("toggle-zen-mode", _, socket) do
    {:noreply, socket |> assign(zen_mode: !socket.assigns.zen_mode)}
  end

  @impl true
  def handle_event("update-content", %{"content" => content}, socket) do
    page =
      if socket.assigns.page.date == Date.utc_today() do
        Page.update_content!(socket.assigns.page, content)
      else
        Page.create!(socket.assigns.notebook)
      end

    {:noreply, socket |> assign(:page, page)}
  end

  @impl true
  def handle_event("recover-content", %{"content" => content}, socket) do
    page =
      case Page.get_today(socket.assigns.notebook) do
        nil -> Page.create!(socket.assigns.notebook)
        page -> Page.update_content!(page, content)
      end

    {:noreply, socket |> assign(:page, page)}
  end

  defp get_notebook_name(%{name: nil} = notebook), do: "Notebook #{notebook.id}"
  defp get_notebook_name(notebook), do: notebook.name
end
