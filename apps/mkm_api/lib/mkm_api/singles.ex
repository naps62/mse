defmodule MkmAPI.Singles do
  import Ecto.{Query, Changeset}

  require Logger

  alias DB.{SilentRepo, Models.Card, Models.Single}

  def fetch do
    cards_with_oudated_single()
    |> Stream.each(&fetch_single_for_card/1)
    |> Stream.run
  end

  defp cards_with_oudated_single do
    Card
    |> where([c], is_nil(c.single_id))
    |> where([c], not is_nil(c.mkm_basic_data))
    |> preload(:single)
    |> DB.Stream.stream(SilentRepo)
  end

  defp fetch_single_for_card(%Card{} = card) do
    case MKM.meta_product(mkm_id: card.mkm_basic_data["idMetaproduct"]) do
      {:ok, single_data} ->
        SilentRepo.transaction(fn ->
          {:ok, single} = insert_or_update_single(single_data)
          associate_single_with_card(single, card)
        end)
      {:error, message} ->
        Logger.info("error importing single: " <> message)
    end
  end

  defp insert_or_update_single(%{"idMetaproduct" => mkm_id} = data) do
    MkmAPI.Singles.Save.save(data)
  end

  defp associate_single_with_card(single, card) do
    change(card)
    |> put_assoc(:single, single)
    |> SilentRepo.update
  end
end
