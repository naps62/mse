defmodule MseWeb.PageController do
  use MseWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
