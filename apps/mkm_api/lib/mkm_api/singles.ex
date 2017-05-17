defmodule MkmAPI.Singles do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Card, Models.Single}

  def fetch do
    cards_with_oudated_single()
    |> Enum.map(&fetch_single_for_card/1)
  end

  def parse do
    Single
    |> SilentRepo.all
    |> Enum.each(&parse_single/1)
  end

  defp cards_with_oudated_single do
    Card
    |> where([c], is_nil(c.single_id))
    |> where([c], not is_nil(c.mkm_basic_data))
    |> preload(:single)
    |> SilentRepo.all
  end

  defp fetch_single_for_card(%Card{} = card) do
    case MKM.meta_product(mkm_id: card.mkm_basic_data["idMetaproduct"]) do
      {:ok, single_data} ->
        SilentRepo.transaction(fn ->
          {:ok, single} = insert_or_update_single(single_data)
          associate_single_with_card(single, card)
        end)
    end
  end

  defp insert_or_update_single(%{"idMetaproduct" => mkm_id} = data) do
    existing = Single
    |> where([s], s.mkm_id == ^mkm_id)
    |> SilentRepo.one

    (existing || %Single{})
    |> single_changeset(data)
    |> SilentRepo.insert_or_update
  end

  defp parse_single(%Single{mkm_data: data} = single) do
    single_changeset(single, data)
    |> SilentRepo.update
  end

  defp single_changeset(single, data) do
    change(single)
    |> put_change(:mkm_data, data)
    |> put_change(:mkm_id, data["idMetaproduct"])
    |> put_change(:mkm_updated_at, Timex.now)
    |> put_change(:name, data["enName"])
    |> put_change(:image_url, image_url(relative_url: data["image"]))
  end

  defp associate_single_with_card(single, card) do
    change(card)
    |> put_assoc(:single, single)
    |> SilentRepo.update
  end

  defp image_url(relative_url: "." <> relative_url), do:
    "https://mkmapi.eu" <> relative_url
end
