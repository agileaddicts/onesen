defmodule OnesenWeb.PageController do
  use OnesenWeb, :controller

  def home(conn, _params) do
    render(conn, :home, page_title: "Home")
  end
end
