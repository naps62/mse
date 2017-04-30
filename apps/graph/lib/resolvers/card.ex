defmodule Graph.Resolvers.Card do
  import Ecto.Query

  def for_set(%{set_id: set_id, search: search}, _info) do
    query = from c in DB.Models.Card,
      where: c.set_mtgio_id == ^set_id,
      where: ilike(c.name, ^"%#{search}%")

    {:ok, DB.Repo.all(query)}
  end

  def find(%{id: mtgio_id}, _info) do
    {:ok, DB.Repo.get_by(DB.Models.Card, mtgio_id: mtgio_id)}
  end
end
