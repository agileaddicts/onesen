defmodule OnesenWeb.PageController do
  use OnesenWeb, :controller

  def home(conn, _params) do
    put_layout(conn, html: :hero)
    render(conn, :home, page_title: "Home", zen_mode: false)
  end
end
