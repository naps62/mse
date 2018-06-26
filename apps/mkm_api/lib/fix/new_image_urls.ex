defmodule Mtgsearch.MkmApi.Fix.NewImageUrls do
  alias DB.Models.{Single, Card}
  alias DB.Repo

  import Ecto.Query

  def run do
    update_singles
    update_cards_by_set
  end

  def update_singles do
    do_update_singles(500, 0)
  end

  def do_update_singles(limit, offset) do
    singles =
      Single
      |> limit(^limit)
      |> offset(^offset)
      |> Repo.all()

    case singles do
      [] ->
        nil

      _ ->
        Enum.each(&MkmAPI.Singles.update_single/1)

        do_update_singles(limit, offset + limit)
    end
  end

  def update_cards_by_set do
    Set
    |> Repo.all()
    |> Enum.each(&MkmAPI.CardsBasic.fetch/1)
  end
end
