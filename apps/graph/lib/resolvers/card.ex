defmodule Graph.Resolvers.Card do
  import Ecto.Query

  alias DB.{Models.Card, Repo}

  def find(%{id: mtgio_id}, _info) do
    {:ok, Repo.get_by(scope(), mtgio_id: mtgio_id)}
  end

  def search(params, _info) do
    query = search_query(params)

    {:ok, Repo.all(query)}
  end

  defp search_query(params) do
    params
    |> Enum.reduce(scope(), &add_query_param/2)
  end

  defp add_query_param({:set_id, nil}, query), do: query
  defp add_query_param({:set_id, set_id}), do:
    query |> where(set_mtgio_id: ^set_id)

  defp add_query_param({:search, search}, query), do:
    query |> where([c], ilike(c.name, ^"%#{search}%"))

  defp add_query_param({:limit, limit}, query), do:
    query |> limit(^limit)

  defp scope do
    Card |> preload(:set)
  end
end
