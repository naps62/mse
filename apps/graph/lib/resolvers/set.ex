defmodule Graph.Resolvers.Set do
  import Ecto.Query

  def all(%{search: search}, _info) do
    query = from s in DB.Models.Set,
      where: ilike(s.name, ^"%#{search}%")

    {:ok, DB.Repo.all(query)}
  end
  def all(_args, _info) do
    {:ok, DB.Repo.all(DB.Models.Set)}
  end

  def find(%{id: mtgio_id}, _info) do
    {:ok, DB.Repo.get_by(DB.Models.Set, mtgio_id: mtgio_id)}
  end
end
