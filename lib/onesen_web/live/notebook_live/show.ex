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
     |> assign(:page_title, "Your notebook")
     |> assign(:notebook, notebook)
     |> assign(:page, page)}
  end
end
