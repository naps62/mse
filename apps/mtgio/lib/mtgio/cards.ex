defmodule Mtgio.Cards do
  alias Ecto.Multi
  import Ecto.Query
  import Ecto.Changeset

  alias DB.{Repo, Models.Card}

  def import(page \\ 1) do
    case MTG.cards(params: %{page: page}) do
      {:ok, []} -> nil

      {:ok, cards} ->
        import_page(cards)
        __MODULE__.import(page + 1)

      _ -> IO.inspect "Something went wrong on Mtgio.Cards.import/0"
    end
  end

  def update do
    Repo.all(Card)
    |> Enum.reduce(Multi.new, &update_card/2)
    |> Repo.transaction
  end

  def import_page(cards) do
    cards
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
    |> put_change(:set_mtgio_id, Map.get(data, :set))
    |> put_change(:name, Map.get(data, :name))
    |> put_change(:manacost, Map.get(data, :manaCost))
  end

  def update_card(card, multi) do
    Multi.update(multi, card.id, update_card_changeset(card))
  end

  def update_card_changeset(%Card{} = card) do
    change(card)
    |> put_change(:name, Map.get(card.mtgio_data, "name"))
    |> put_change(:image_url, Map.get(card.mtgio_data, "imageUrl"))
    |> put_change(:manacost, Map.get(card.mtgio_data, "manaCost"))
  end
end
