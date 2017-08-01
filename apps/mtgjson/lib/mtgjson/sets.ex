defmodule Mtgjson.Sets do
  alias DB.{SilentRepo, Models.Set}
  alias Mtgjson.Parser

  import Ecto.Query
  import Ecto.Changeset

  def import({:data, data}) do
    data
    |> Parser.parse
    |> Enum.each(&update_set/1)
  end

  def import({:file, file}) do
    file
    |> Parser.parse_from_file
    |> Enum.each(&update_set/1)
  end

  defp update_set({mtgjson_code, %{"name" => name} = data}) do
    mkm_id = Map.get(data, "mkm_id")

    case find_sets(mtgjson_code, data) do
      [] ->
        IO.puts "    No set found for #{mtgjson_code} - #{Map.get(data, "name")} (mkm_id: #{mkm_id})"
      sets ->
        sets
        |> Enum.each fn(set) ->
          changeset(set, mtgjson_code, data)
          |> SilentRepo.update

          Mtgjson.Cards.import(set, Map.get(data, "cards"))
        end
    end
  end

  defp find_sets(mtgjson_code, data) do
    Mtgjson.Sets.Finder.find(mtgjson_code, data)
  end

  defp changeset(set, code, data) do
    change(set)
    |> put_change(:mtgjson_codes, [code | set.mtgjson_codes] |> Enum.uniq)
    |> put_change(:mtgjson_data, Map.delete(data, "cards"))
  end
end
