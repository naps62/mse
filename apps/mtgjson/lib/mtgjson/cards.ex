defmodule Mtgjson.Cards do
  alias DB.SilentRepo

  import Ecto.Query
  import Ecto.Changeset

  def import(set, cards) do
    cards
    |> Enum.each(&update_card(set, &1))
  end

  defp update_card(set, %{"id" => id, "name" => name} = data) do
    case find_card(set, id, name) do
      nil ->
        IO.puts "No card found for #{set.name} - #{name}"
      card ->
        changeset(card, data)
        |> SilentRepo.update
    end
  end

  defp find_card(set, id, name) do
    set
    |> Ecto.assoc(:cards)
    |> where(
      [c],
      (c.mtgjson_id == ^id) or
      (is_nil(c.mtgjson_id) and c.name == ^name)
    )
    |> SilentRepo.one
  end

  defp changeset(card, data) do
    change(card)
    |> put_change(:mtgjson_id, Map.get(data, "id"))
    |> put_change(:mtgjson_data, data)
    |> put_change(:artist, Map.get(data, "artist"))
    |> put_change(:rarity, Map.get(data, "rarity") |> String.downcase)
  end
end
