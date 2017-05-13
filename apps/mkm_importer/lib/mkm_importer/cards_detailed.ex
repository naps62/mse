defmodule MkmImporter.CardsDetailed do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Card}

  def fetch do
    cards_with_outdated_detailed_data_first()
    |> Enum.each(&fetch/1)
  end

  def fetch(%Card{mkm_id: mkm_id} = card) do
    case MKM.product(mkm_id: mkm_id) do
      {:ok, card_data} ->
        changeset(card, card_data)
        |> SilentRepo.update

      _ ->
        IO.puts "Could not update card with mkm_id: #{mkm_id}"
    end
  end

  defp cards_with_outdated_detailed_data_first do
    Card
    |> order_by([c], [
      desc: is_nil(c.mkm_detailed_updated_at),
      asc: c.mkm_detailed_updated_at,
    ])
    |> SilentRepo.all
  end

  defp changeset(card, data) do
    change(card)
    |> put_change(:mkm_detailed_data, data)
    |> put_change(:mkm_detailed_updated_at, Timex.now)
  end
end
