defmodule OnesenWeb.NotebookLiveTest do
  use OnesenWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Onesen.Models.Notebook
  alias Onesen.Models.Page

  setup do
    notebook = Notebook.create!()
    %{notebook: notebook}
  end

  test "displays notebook", %{conn: conn, notebook: notebook} do
    {:ok, _view, html} = live(conn, ~p"/n/#{notebook.identifier}")

    assert html =~ "Your notebook"
    assert html =~ Date.utc_today() |> to_string()
  end

  test "writes content in notebook", %{conn: conn, notebook: notebook} do
    {:ok, view, _html} = live(conn, ~p"/n/#{notebook.identifier}")

    assert view
           |> element("form")
           |> render_change(%{content: "Lorem ipsum"}) =~ "Lorem ipsum"

    loaded_page = Page.get_today(notebook)
    assert loaded_page.content == "Lorem ipsum"
  end
end
