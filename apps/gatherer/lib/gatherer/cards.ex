defmodule Gatherer.Cards do
  alias DB.{SilentRepo, Models.Card, Models.Set}
  alias Ecto.Multi

  import Ecto.Query
  import Ecto.Changeset

  def import(data) do
    data
    |> Enum.reduce(Multi.new, &update_card/2)
    |> SilentRepo.transaction
  end

  defp update_card(data, multi) do
    case find_card(data) do
      nil ->
        IO.puts "Warning: could not find card #{data.id} - #{data.name}"
        multi
      card ->
        Multi.update(multi, card.id, changecard(card, data))
    end
  end

  defp find_card(%{id: id, name: name, set: set_gatherer_code}) do
    case find_set(set_gatherer_code) do
      nil ->
        nil
      set ->
        find_card_in_set(set, id, name)
    end
  end

  defp find_set(set_gatherer_code) do
    Set
    |> where([s], s.gatherer_code == ^set_gatherer_code)
    |> SilentRepo.one
  end

  defp find_card_in_set(set, id, name) do
    set
    |> Ecto.assoc(:cards)
    |> where([c], c.gatherer_id == ^id or c.name == ^name)
    |> SilentRepo.one
  end

  defp changecard(card, data) do
    change(card)
    |> put_change(:gatherer_data, data)
    |> put_change(:gatherer_id, data[:id])
    |> put_change(:gatherer_updated_at, Timex.now)
    |> put_change(:artist, data[:artist])
    |> put_change(:rarity, data[:rarity])
  end
end
