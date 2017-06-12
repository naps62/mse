defmodule Mtgjson.Sets do
  alias DB.{SilentRepo, Models.Set}
  alias Mtgjson.Parser

  import Ecto.Query
  import Ecto.Changeset

  def import(file) do
    file
    |> Parser.parse
    |> Enum.each(&update_set/1)
  end

  defp update_set({mtgjson_code, %{"name" => name} = data}) do
    mkm_id = Map.get(data, "mkm_id")

    case find_set(mtgjson_code, mkm_id, name) do
      nil ->
        IO.puts "No set found for #{mtgjson_code} #{Map.get(data, "name")} (mkm_id: #{mkm_id})"
      set ->
        changeset(set, mtgjson_code, data)
        |> SilentRepo.update

        Mtgjson.Cards.import(set, Map.get(data, "cards"))
    end
  end

  defp find_set(mtgjson_code, nil, name) do
    find_set(mtgjson_code, -1, name)
  end
  defp find_set(mtgjson_code, mkm_id, name) do
    Set
    |> where(
      [e], (e.mtgjson_code == ^mtgjson_code) or
      (is_nil(e.mtgjson_code) and e.mkm_id == ^mkm_id) or
      (is_nil(e.mtgjson_code) and e.name == ^name)
    )
    |> SilentRepo.one
  end

  defp changeset(set, code, data) do
    change(set)
    |> put_change(:mtgjson_code, code)
    |> put_change(:mtgjson_data, Map.delete(data, "cards"))
  end
end
