defmodule MkmApi.CardsBasic.Save do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Card, Models.Single}

  def save(set, card_data) do
    case find_card(card_data) do
      nil ->
        new_card = %Card{}
        single_id = single_id_for(new_card, card_data)
        SilentRepo.insert(card_changeset(new_card, card_data, set, single_id))

      card ->
        single_id = single_id_for(card, card_data)
        SilentRepo.update(card_changeset(card, card_data, set, single_id))
    end
  end

  defp find_card(%{"idProduct" => mkm_id}) do
    Card
    |> where([c], c.mkm_id == ^mkm_id)
    |> SilentRepo.one()
  end

  defp card_changeset(card, data, set, single_id) do
    change(card)
    |> put_change(:mkm_basic_data, data)
    |> put_change(:mkm_id, data["idProduct"])
    |> put_change(:mkm_basic_updated_at, Timex.now())
    |> put_change(:mkm_double_faced, double_faced?(data))
    |> put_change(:set_id, set.id)
    |> put_change(:single_id, single_id)
    |> put_change(:mkm_name, data["enName"])
    |> put_change(:name, data["enName"])
    |> put_change(:rarity, String.downcase(data["rarity"]))
    |> put_change(:image_url, mkm_relative_url(data["image"]))
    |> put_change(:mkm_url, mkm_relative_url(data["website"]))
  end

  defp double_faced?(%{"enName" => name}) do
    Regex.match?(~r|\s/{1,2}\s|, name)
  end

  defp single_id_for(%Card{single_id: nil}, data),
    do:
      Single
      |> where([s], s.mkm_id == ^data["idMetaproduct"])
      |> select([s], s.id)
      |> SilentRepo.one()

  defp single_id_for(%Card{single_id: id}, _), do: id

  defp mkm_relative_url("." <> relative_url), do: mkm_relative_url(relative_url)
  defp mkm_relative_url(relative_url), do: "https://mkmapi.eu" <> relative_url
end
