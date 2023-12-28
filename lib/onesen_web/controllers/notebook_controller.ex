defmodule OnesenWeb.NotebookController do
  alias Onesen.Models.Notebook
  use OnesenWeb, :controller

  def create(conn, _params) do
    notebook = Notebook.create!()

    redirect(conn, to: ~p"/n/#{notebook.identifier}")
  end

  def show(conn, %{"identifier" => identifier}) do
    notebook = Notebook.get!(identifier)
    render(conn, :show, page_title: "Notebook", notebook: notebook)
  end
end
