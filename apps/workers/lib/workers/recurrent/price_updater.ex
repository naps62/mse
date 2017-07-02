defmodule Workers.Recurrent.PriceUpdater do
  alias DB.Models.Card
  alias DB.SilentRepo

  import Ecto.Query

  def run do
    top_outdated_cards()
    |> Enum.each(&MkmAPI.CardsDetailed.fetch/1)
  end

  defp top_outdated_cards do
    Card
    |> order_by([c], [
      desc: is_nil(c.mkm_detailed_updated_at),
      asc: c.mkm_detailed_updated_at,
    ])
    |> limit(500)
    |> SilentRepo.all
  end
end
