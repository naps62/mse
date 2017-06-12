defmodule Gatherer.Cards do
  alias DB.{SilentRepo, Models.Card}
  alias Ecto.Multi

  import Ecto.Query
  import Ecto.Changeset

  def import(data) do
    data
    |> Enum.reduce(Multi.new, &update_cards/2)
    |> SilentRepo.transaction
  end

  defp update_cards(data, multi) do
    data
    |> find_cards
    |> Enum.reduce(multi, &update_individual_card(&1, &2, data))
  end

  defp update_individual_card(card, multi, data) do
    Multi.update(multi, card.id, changecard(card, data))
  end

  defp find_cards(%{id: id, name: name, set: set_gatherer_code}) do
    Card
    |> join(:inner, [card], s in assoc(card, :set))
    |> where([_card, set], set.gatherer_code == ^set_gatherer_code)
    |> where([card, _set], card.gatherer_id == ^id or card.name == ^name)
    |> SilentRepo.all
  end

  defp changecard(card, data) do
    change(card)
    |> put_change(:gatherer_data, data)
    |> put_change(:gatherer_id, data[:id])
    |> put_change(:gatherer_updated_at, Timex.now)
    |> put_change(:artist, data[:artist])
    |> put_change(:rarity, gatherer_rarity(data[:rarity]))
  end

  defp gatherer_rarity("R"), do: "rare"
  defp gatherer_rarity("C"), do: "common"
  defp gatherer_rarity("U"), do: "uncommon"
  defp gatherer_rarity("M"), do: "mythic"
  defp gatherer_rarity(str), do: str
end
