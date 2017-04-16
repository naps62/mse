defmodule MseWeb.Web.PageController do
  use MseWeb.Web, :controller
  import Ecto.Query

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
