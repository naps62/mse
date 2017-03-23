defmodule MseWeb.Web.API.SetController do
  use MseWeb.Web, :controller
  import Ecto.Query

  def index(conn, _params) do
    sets = DB.Models.Set |> DB.Repo.all

    render conn, "index.json", sets: sets
  end

  def show(conn, %{"id" => id}) do
    set = DB.Models.Set |> preload(:cards) |> DB.Repo.get(id)

    conn
    |> assign(:set, set)
    |> render "show.json", set: set
  end
end
