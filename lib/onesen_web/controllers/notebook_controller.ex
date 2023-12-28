defmodule OnesenWeb.NotebookController do
  alias Onesen.Models.Notebook
  use OnesenWeb, :controller

  def create(conn, _params) do
    notebook = Notebook.create!()

    redirect(conn, to: ~p"/n/#{notebook.identifier}")
  end
end
