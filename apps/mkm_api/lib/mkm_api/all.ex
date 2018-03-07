defmodule MkmAPI.All do
  alias DB.Models.{Card, Set}
  alias DB.SilentRepo

  import Ecto.Query

  def fetch do
    fetch_new_sets()
    fetch_new_cards()
    fetch_new_detailed_cards()
    fetch_new_singles()
  end

  defp fetch_new_sets do
    Mix.shell().info("Looking for new sets")
    MkmAPI.Sets.fetch()

    count = new_sets_query() |> SilentRepo.aggregate(:count, :id)

    Mix.shell().info("Found #{count} new sets")
  end

  defp fetch_new_cards do
    Mix.shell().info("Importing cards for new sets")

    new_sets_query()
    |> SilentRepo.all()
    |> Enum.each(&MkmAPI.CardsBasic.fetch/1)

    count = new_cards_query() |> SilentRepo.aggregate(:count, :id)

    Mix.shell().info("Found #{count} new cards")
  end

  defp fetch_new_singles do
    count = cards_without_single_query() |> SilentRepo.aggregate(:count, :id)

    Mix.shell().info("Found #{count} cards without single. Importing")
    MkmAPI.Singles.fetch()

    Mix.shell().info("Singles up-to-date")
  end

  defp fetch_new_detailed_cards do
    Mix.shell().info("TODO: fetch_new_detailed_cards")

    count =
      cards_without_detailed_data_query() |> SilentRepo.aggregate(:count, :id)

    Mix.shell().info("Found #{count} cards without detailed data. Importing")

    cards_without_detailed_data_query()
    |> SilentRepo.all()
    |> Enum.each(&MkmAPI.CardsDetailed.fetch/1)

    Mix.shell().info("Singles up-to-date")
  end

  defp new_sets_query do
    Set
    |> where([s], is_nil(s.mkm_cards_updated_at))
  end

  defp new_cards_query do
    Card
    |> where([c], is_nil(c.mkm_detailed_data))
  end

  defp cards_without_single_query do
    Card
    |> where([c], is_nil(c.single_id))
  end

  defp cards_without_detailed_data_query do
    Card
    |> where([c], is_nil(c.mkm_detailed_data))
  end
end
