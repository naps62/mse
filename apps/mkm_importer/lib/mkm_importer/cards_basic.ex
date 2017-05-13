defmodule MkmImporter.CardsBasic do
  alias Ecto.Multi
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Card, Models.Set, Models.Single}

  def fetch do
    sets_with_outdated_cards_first()
    |> Enum.each(&fetch/1)
  end

  def fetch(%Set{mkm_id: mkm_set_id} = set) do
    cards_data = case MKM.expansion_singles(expansion_mkm_id: mkm_set_id) do
      {:ok, singles} -> singles
      _ -> []
    end

    cards_data
    |> Enum.reduce(Multi.new, &insert_or_update_card_for_set(set, &1, &2))
    |> update_set_timestamp(set)
    |> SilentRepo.transaction
  end

  def parse do
    sets_with_outdated_cards_first()
    |> Enum.each(&parse/1)
  end

  def parse(%Set{id: id}) do
    Card
    |> where([c], c.set_id == ^id)
    |> preload(:set)
    |> SilentRepo.all
    |> Enum.each(&parse_card/1)
  end

  defp sets_with_outdated_cards_first do
    Set
    |> order_by([s], [
      desc: is_nil(s.mkm_cards_updated_at),
      asc: s.mkm_cards_updated_at,
    ])
    |> SilentRepo.all
  end

  defp insert_or_update_card_for_set(set, %{"idProduct" => mkm_id} = card_data, multi) do
    case find_card(card_data) do
      nil ->
        new_card = %Card{}
        Multi.insert(multi, mkm_id, card_changeset(new_card, card_data, set))
      card ->
        Multi.update(multi, mkm_id, card_changeset(card, card_data, set))
    end
  end

  defp find_card(%{"idProduct" => mkm_id}) do
    Card
    |> where([c], c.mkm_id == ^mkm_id)
    |> SilentRepo.one
  end

  defp parse_card(card) do
    card_changeset(card, card.mkm_basic_data, card.set)
    |> SilentRepo.update
  end

  defp card_changeset(card, data, set) do
    change(card)
    |> put_change(:mkm_basic_data, data)
    |> put_change(:mkm_id, data["idProduct"])
    |> put_change(:mkm_basic_updated_at, Timex.now)
    |> put_change(:set_id, set.id)
    |> put_change(:single_id, single_id_for(card, data))
    |> put_change(:name, data["enName"])
    |> put_change(:rarity, String.downcase(data["rarity"]))
    |> put_change(:image_url, image_url(relative_url: data["image"]))
  end

  defp update_set_timestamp(multi, set) do
    changeset = change(set)
    |> put_change(:mkm_cards_updated_at, Timex.now)

    Multi.update(multi, "set_timestamp", changeset)
  end

  defp single_id_for(%Card{single_id: nil}, data), do:
    Single
    |> where([s], s.mkm_id == ^data["idMetaproduct"])
    |> select([s], s.id)
    |> SilentRepo.one
  defp single_id_for(%Card{single_id: id}, _), do:
    id

  defp image_url(relative_url: "." <> relative_url), do:
    "https://mkmapi.eu" <> relative_url
end
