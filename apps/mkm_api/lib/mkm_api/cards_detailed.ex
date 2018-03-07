defmodule MkmAPI.CardsDetailed do
  import Ecto.{Query, Changeset}
  require Logger

  alias DB.{SilentRepo, Models.Card}

  def fetch(:new) do
    new_cards_only()
    |> Enum.each(&fetch/1)
  end

  def fetch(%Card{mkm_id: mkm_id} = card) do
    Logger.info(fn ->
      "[MkmAPI.CardsDetailed] fetching ##{card.id} - #{card.name}"
    end)

    case MKM.product(mkm_id: mkm_id) do
      {:ok, card_data} ->
        changeset(card, card_data)
        |> SilentRepo.update()

      _ ->
        Logger.info(fn -> "Could not update card with mkm_id: #{mkm_id}" end)
    end
  end

  def fetch do
    cards_with_outdated_detailed_data_first()
    |> Stream.each(&fetch/1)
    |> Stream.run()
  end

  def parse(%Card{} = card) do
    changeset(card, card.mkm_detailed_data)
    |> SilentRepo.update()
  end

  defp cards_with_outdated_detailed_data_first do
    Card
    |> order_by(
      [c],
      desc: is_nil(c.mkm_detailed_updated_at),
      asc: c.mkm_detailed_updated_at
    )
    |> DB.Stream.stream(SilentRepo)
  end

  defp new_cards_only do
    Card
    |> where([c], is_nil(c.mkm_detailed_updated_at))
    |> DB.Stream.stream(SilentRepo)
  end

  defp changeset(card, data) do
    change(card)
    |> put_change(:mkm_price_trend, round(data["priceGuide"]["TREND"] * 100))
    |> put_change(:mkm_foil_low, round(data["priceGuide"]["LOWFOIL"] * 100))
    |> put_change(:mkm_detailed_data, data)
    |> put_change(:mkm_detailed_updated_at, Timex.now())
  end
end
