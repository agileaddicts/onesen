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
           |> element("form#update-content-form")
           |> render_change(%{content: "Lorem ipsum"}) =~ "Lorem ipsum"

    loaded_page = Page.get_today(notebook)
    assert loaded_page.content == "Lorem ipsum"
  end

  test "displays content in notebook", %{conn: conn, notebook: notebook} do
    page = Page.create!(notebook)
    Page.update_content!(page, "Lorem ipsum")

    {:ok, _view, html} = live(conn, ~p"/n/#{notebook.identifier}")

    assert html =~ "Lorem ipsum"
  end

  test "updates title of notebook", %{conn: conn, notebook: notebook} do
    {:ok, view, _html} = live(conn, ~p"/n/#{notebook.identifier}")

    assert view
           |> element("form#update-notebook-name-form")
           |> render_change(%{name: "Test NB 1"}) =~ "Test NB 1"

    loaded_notebook = Notebook.get!(notebook.identifier)
    assert loaded_notebook.name == "Test NB 1"
  end

  test "displays title of notebook", %{conn: conn, notebook: notebook} do
    Notebook.update_name!(notebook, "Test NB 1")
    {:ok, _view, html} = live(conn, ~p"/n/#{notebook.identifier}")

    assert html =~ "Test NB 1"
  end
end
