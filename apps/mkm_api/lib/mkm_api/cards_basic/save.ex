defmodule MkmApi.CardsBasic.Save do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Card, Models.Single}

  def save(set, card_data) do
    if card_is_double_faced(card_data) do
      insert_or_update(set, card_data, double_faced: true, back_face: false)
      insert_or_update(set, card_data, double_faced: true, back_face: true)
    else
      insert_or_update(set, card_data, double_faced: false, back_face: false)
    end
  end

  defp card_is_double_faced(%{"enName" => name}) do
    Regex.match?(~r|\s/{1,2}\s|, name)
  end

  defp insert_or_update(
    set,
    card_data,
    double_faced: double_faced,
    back_face: back_face
  ) do
    case find_card(card_data, double_faced: double_faced, back_face: back_face) do
      nil ->
        new_card = %Card{mkm_double_faced: double_faced, mkm_back_face: back_face}
        SilentRepo.insert(card_changeset(new_card, card_data, set))
      card ->
        SilentRepo.update(card_changeset(card, card_data, set))
    end
  end

  defp find_card(
    %{"idProduct" => mkm_id},
    double_faced: double_faced,
    back_face: back_face
  ) do
    Card
    |> where(
      [c],
      c.mkm_id == ^mkm_id and
      c.mkm_double_faced == ^double_faced and
      c.mkm_back_face == ^back_face
    )
    |> SilentRepo.one
  end

  defp card_changeset(card, data, set) do
    change(card)
    |> put_change(:mkm_basic_data, data)
    |> put_change(:mkm_id, data["idProduct"])
    |> put_change(:mkm_basic_updated_at, Timex.now)
    |> put_change(:set_id, set.id)
    |> put_change(:single_id, single_id_for(card, data))
    |> put_change(:mkm_name, data["enName"])
    |> put_change(:name, name_for_card(card, data["enName"]))
    |> put_change(:rarity, String.downcase(data["rarity"]))
    |> put_change(:image_url, mkm_relative_url(data["image"]))
    |> put_change(:mkm_url, mkm_relative_url(data["website"]))
  end

  defp name_for_card(card, name) do
    cond do
      double_faced?(card) and back_face?(card) ->
        Regex.run(~r|/+\s+(.+)$|, name)
        |> Enum.at(1)
      double_faced?(card) and not back_face?(card) ->
        Regex.run(~r|^(.+)\s+/+|, name)
        |> Enum.at(1)
      true ->
        name
    end
  end

  defp double_faced?(%Card{mkm_double_faced: double_faced}), do: double_faced
  defp back_face?(%Card{mkm_back_face: back_face}), do: back_face

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
