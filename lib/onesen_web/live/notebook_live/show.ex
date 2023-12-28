defmodule OnesenWeb.Live.NotebookLive.Show do
  use OnesenWeb, :live_view

  alias Onesen.Models.Notebook

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"identifier" => identifier}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Your notebook")
     |> assign(:notebook, Notebook.get!(identifier))}
  end
end
