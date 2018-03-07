defmodule Graph.Resolvers.Single do
  import Ecto.Query

  alias DB.{Models.Single, Repo}

  def page(%{offset: offset, limit: limit}, _info) do
    query =
      Single
      |> order_by([s], asc: s.id)
      |> offset(^offset)
      |> limit(^limit)

    {:ok, Repo.all(query)}
  end
end
