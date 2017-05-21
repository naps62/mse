defmodule Graph.Resolvers.Set do
  import Ecto.Query

  alias DB.{Models.Set, Repo}

  def search(params, _info) do
    query = search_query(params)

    {:ok, Repo.all(query)}
  end

  def find(%{id: id}, _info) do
    {:ok, Repo.get(scope(), id)}
  end

  defp search_query(params) do
    params
    |> Enum.reduce(scope(), &add_query_param/2)
  end

  defp add_query_param({:search, ""}, query), do: query
  defp add_query_param({:search, search}, query), do:
    query |> where([s], ilike(s.name, ^"%#{search}%"))

  defp add_query_param({:limit, :infinity}, query), do: query
  defp add_query_param({:limit, limit}, query), do:
    query |> limit(^limit)

  defp scope do
    Set
  end
end
