defmodule Mse.Web.PageController do
  use Mse.Web, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
