defmodule Mtgjson.Sets do
  alias DB.{SilentRepo, Models.Set}
  alias Mtgjson.Parser
  require Logger

  import Ecto.Query
  import Ecto.Changeset

  alias MseLogging.FileLogger
  @logfile "mtgjson.sets.log"

  def import({:data, data}) do
    data
    |> Parser.parse()
    |> Enum.each(&update_set/1)
  end

  def import({:file, file}) do
    file
    |> Parser.parse_from_file()
    |> Enum.each(&update_set/1)
  end

  defp update_set({mtgjson_code, %{"name" => name} = data}) do
    mkm_id = Map.get(data, "mkm_id")

    Logger.info(fn -> "[Mtgjson] Updating set #{name}" end)

    case find_sets(mtgjson_code, data) do
      [] ->
        FileLogger.append(
          @logfile,
          "No set found #{mtgjson_code} - mkm_id: #{mkm_id}, name: #{
            Map.get(data, "name")
          }"
        )

      sets ->
        sets
        |> Enum.each(fn set ->
          changeset(set, mtgjson_code, data)
          |> SilentRepo.update()

          if outdated_cards_in_set?(set) do
            Mtgjson.Cards.import(set, Map.get(data, "cards"))
          end
        end)
    end
  end

  defp outdated_cards_in_set?(set) do
    set
    |> Ecto.assoc(:cards)
    |> where([c], is_nil(c.mtgjson_data))
    |> DB.SilentRepo.all()
    |> Enum.any?()
  end

  defp find_sets(mtgjson_code, data) do
    Mtgjson.Sets.Finder.find(mtgjson_code, data)
  end

  defp changeset(set, code, data) do
    change(set)
    |> put_change(:mtgjson_codes, [code | set.mtgjson_codes] |> Enum.uniq())
    |> put_change(:mtgjson_data, Map.delete(data, "cards"))
  end
end
