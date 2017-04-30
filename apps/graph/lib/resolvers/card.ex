defmodule Graph.Resolvers.Card do
  import Ecto.Query

  def for_set(%{set_id: set_id}) do
    query = from c in DB.Models.Card, where: c.set_id == ^set_id

    {:ok, DB.Repo.all(query)}
  end
end
