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
     |> assign(:state, :default)
     |> assign(:page_title, "Your notebook")
     |> assign(:notebook, notebook)
     |> assign(:page, page)}
  end

  def handle_event("state-default", _params, socket) do
    {:noreply, socket |> assign(:state, :default)}
  end

  def handle_event("state-edit-name", _params, socket) do
    {:noreply, socket |> assign(:state, :edit_name)}
  end

  @impl true
  def handle_event("update-notebook-name", %{"name" => name}, socket) do
    notebook = Notebook.update_name!(socket.assigns.notebook, name)

    {:noreply, socket |> assign(notebook: notebook)}
  end

  @impl true
  def handle_event("save-notebook-name", %{"name" => name}, socket) do
    notebook = Notebook.update_name!(socket.assigns.notebook, name)

    {:noreply, socket |> assign(notebook: notebook, state: :default)}
  end

  @impl true
  def handle_event("update-content", %{"content" => content}, socket) do
    page = Page.update_content!(socket.assigns.page, content)

    {:noreply, socket |> assign(:page, page)}
  end

  defp get_notebook_name(%{name: nil} = notebook), do: "Notebook #{notebook.id}"
  defp get_notebook_name(notebook), do: notebook.name
end
