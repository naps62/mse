defmodule Mtgjson.Cards do
  alias DB.SilentRepo

  import Ecto.Query
  import Ecto.Changeset
  alias MseLogging.FileLogger

  @logfile "mtgjson.cards.log"

  def import(set, cards) do
    cards
    |> Enum.each(&update_card(set, &1))
  end

  defp update_card(set, %{"name" => name} = data) do
    case find_cards(set, data) do
      [] ->
        FileLogger.append(@logfile, "No card found for set: #{set.name}, #{name}")
      cards ->
        Enum.each(cards, fn(card) ->
          changeset(card, data)
          |> SilentRepo.update
        end)
    end
  end

  defp find_cards(set, data) do
    Mtgjson.Cards.Finder.find(set, data)
  end

  defp changeset(card, data) do
    change(card)
    |> put_change(:mtgjson_id, Map.get(data, "id"))
    |> put_change(:mtgjson_data, data)
    |> put_change(:artist, Map.get(data, "artist"))
    |> put_change(:rarity, Map.get(data, "rarity") |> String.downcase)
  end
end
