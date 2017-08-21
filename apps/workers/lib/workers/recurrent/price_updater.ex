defmodule Workers.Recurrent.PriceUpdater do
  alias DB.Models.Card
  alias DB.SilentRepo
  alias Workers.Logger

  import Ecto.Query

  @limit 500

  def run do
    log = Logger.job_start(%{
      module: __MODULE__ |> to_string,
      name: "Updating MKM prices for #{@limit} cards"}
    )

    cards = top_outdated_cards()
    Enum.each(cards, &MkmAPI.CardsDetailed.fetch/1)

    Logger.job_end(log, %{status: :success})
  end

  defp top_outdated_cards do
    Card
    |> order_by([c], [
      desc: is_nil(c.mkm_detailed_updated_at),
      asc: c.mkm_detailed_updated_at,
    ])
    |> limit(@limit)
    |> SilentRepo.all
  end
end
