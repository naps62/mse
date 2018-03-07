defmodule Graph.Resolvers.Card do
  import Ecto.Query

  alias DB.{Models.Card, Repo}

  def find(%{id: id}, _info) do
    {:ok, Repo.get_by(scope(), id: id)}
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

  defp add_query_param({:set_id, set_id}, query),
    do: query |> where(set_id: ^set_id)

  defp add_query_param({:search, search}, query),
    do: query |> where([c], ilike(c.name, ^"%#{search}%"))

  defp add_query_param({:limit, :infinity}, query), do: query
  defp add_query_param({:limit, limit}, query), do: query |> limit(^limit)

  defp add_query_param({:mkm_detailed_updated_at, nil}, query), do: query

  defp add_query_param({:mkm_detailed_updated_at, datetime}, query) do
    parsed_datetime = Timex.parse!(datetime, "{ISO:Extended}")

    query
    |> where([c], c.mkm_detailed_updated_at >= ^parsed_datetime)
  end

  defp scope do
    Card
    |> preload([:set, :single])
    |> order_by([c], asc: :id)
  end
end
