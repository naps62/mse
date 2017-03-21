defmodule MseWeb.Web.PageController do
  use MseWeb.Web, :controller

  def index(conn, _params) do
    sets = DB.Models.Set |> DB.Repo.all
    IO.inspect sets

    conn
    |> assign(:sets, sets)
    |> render "index.html"
  end
end
