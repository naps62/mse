defmodule Mtgio.Cards do
  alias Ecto.Multi
  import Ecto.Query
  import Ecto.Changeset

  alias DB.{Repo, Models.Card}

  def import do
    {:ok, sets} = MTG.cards

    sets
    |> Enum.reduce(Multi.new, &add_card/2)
    |> Repo.transaction
  end

  def add_card(card_data, multi) do
    case find_card(card_data) do
      nil -> Multi.insert(multi, card_data.id, card_changeset(%Card{}, card_data))
      card -> Multi.update(multi, card_data.id, card_changeset(card, card_data))
    end
  end

  def find_card(%{id: mtgio_id}) do
    Card |> where(mtgio_id: ^mtgio_id) |> Repo.one
  end

  def card_changeset(%Card{} = card, data) do
    change(card)
    |> put_change(:mtgio_data, data)
    |> put_change(:mtgio_id, data.id)
    |> put_change(:name, Map.get(data, :name))
  end
end
