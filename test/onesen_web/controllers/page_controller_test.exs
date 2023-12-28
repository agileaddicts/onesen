defmodule OnesenWeb.PageControllerTest do
  use OnesenWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "1sen"
  end
end
