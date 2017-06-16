defmodule MkmAPI.CardsBasic do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Card, Models.Set, Models.Single}

  def fetch do
    sets_with_new_cards()
    |> Enum.each(&fetch/1)
  end

  def fetch(%Set{mkm_id: mkm_set_id} = set) do
    cards_data = case MKM.expansion_singles(expansion_mkm_id: mkm_set_id) do
      {:ok, singles} -> singles
      _ -> []
    end

    SilentRepo.transaction fn ->
      cards_data
      |> Enum.each(&insert_or_update_card_for_set(set, &1))
      update_set_timestamp(set)
    end
  end

  def parse do
    sets_with_new_cards()
    |> Enum.each(&parse/1)
  end

  def parse(%Set{id: id}) do
    Card
    |> where([c], c.set_id == ^id)
    |> preload(:set)
    |> SilentRepo.all
    |> Enum.each(&parse_card/1)
  end

  defp sets_with_new_cards do
    Set
    |> join(:left, [s], c in assoc(s, :cards))
    |> where([s, c], is_nil(c.mkm_basic_updated_at))
    |> select([s, c], s)
    |> SilentRepo.all
  end

  defp insert_or_update_card_for_set(set, card_data) do
    case find_card(card_data) do
      nil ->
        new_card = %Card{}
        SilentRepo.insert(card_changeset(new_card, card_data, set))
      card ->
        SilentRepo.update(card_changeset(card, card_data, set))
    end
  end

  defp find_card(%{"idProduct" => mkm_id}) do
    Card
    |> where([c], c.mkm_id == ^mkm_id)
    |> SilentRepo.one
  end

  defp parse_card(card) do
    card_changeset(card, card.mkm_basic_data, card.set)
    |> DB.Repo.update
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
    |> put_change(:image_url, mkm_relative_url(data["image"]))
    |> put_change(:mkm_url, mkm_relative_url(data["website"]))
  end

  defp update_set_timestamp(set) do
    changeset = change(set)
    |> put_change(:mkm_cards_updated_at, Timex.now)

    SilentRepo.update(changeset)
  end

  defp single_id_for(%Card{single_id: nil}, data), do:
    Single
    |> where([s], s.mkm_id == ^data["idMetaproduct"])
    |> select([s], s.id)
    |> SilentRepo.one
  defp single_id_for(%Card{single_id: id}, _), do:
    id

  defp mkm_relative_url("." <> relative_url), do: mkm_relative_url(relative_url)
  defp mkm_relative_url(relative_url), do:
    "https://mkmapi.eu" <> relative_url
end
