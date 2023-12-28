defmodule OnesenWeb.NotebookLiveTest do
  alias Onesen.Models.Notebook
  use OnesenWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Onesen.Models.Notebook

  defp create_notebook(_) do
    notebook = Notebook.create!()
    %{notebook: notebook}
  end

  setup [:create_notebook]

  test "displays notebook", %{conn: conn, notebook: notebook} do
    {:ok, _show_live, html} = live(conn, ~p"/n/#{notebook.identifier}")

    assert html =~ "Your notebook"
  end
end
