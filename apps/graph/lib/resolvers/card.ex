defmodule Graph.Resolvers.Card do
  import Ecto.Query

  def find(%{id: mtgio_id}, _info) do
    {:ok, DB.Repo.get_by(DB.Models.Card, mtgio_id: mtgio_id)}
  end

  def search(params, _info) do
    query = search_query(params)

    {:ok, DB.Repo.all(query)}
  end

  defp search_query(%{set_id: set_id} = params), do: search_for_set(set_id, params)
  defp search_query(params), do: search_with_limited_results(params)

  defp search_for_set(set_id, params), do: base_query(params) |> where(set_mtgio_id: ^set_id)
  defp search_with_limited_results(params), do: base_query(params) |> limit(10)

  defp base_query(%{search: search}) do
    DB.Models.Card
    |> where([c], ilike(c.name, ^"%#{search}%"))
  end
end
