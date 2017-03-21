defmodule MseWeb.Web.SetController do
  use MseWeb.Web, :controller
  import Ecto.Query

  def index(conn, _params) do
    sets = DB.Models.Set |> DB.Repo.all

    conn
    |> assign(:sets, sets)
    |> render "index.html"
  end

  def show(conn, %{"id" => id}) do
    set = DB.Models.Set |> preload(:cards) |> DB.Repo.get(id)

    conn
    |> assign(:set, set)
    |> render "show.html"
  end
end
