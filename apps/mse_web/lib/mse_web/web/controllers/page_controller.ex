defmodule MseWeb.Web.PageController do
  use MseWeb.Web, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
