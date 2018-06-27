defmodule MkmAPI.Fix.NewImageUrls do
  alias DB.Models.{Single, Card, Set}
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
    IO.inspect("updating singles from #{offset} to #{offset + limit - 1}")

    singles =
      Single
      |> order_by([s], asc: :id)
      |> where([s], like(s.image_url, "%/img/cards%"))
      |> limit(^limit)
      |> offset(^offset)
      |> Repo.all()

    case singles do
      [] ->
        nil

      _ ->
        Enum.each(singles, &MkmAPI.Singles.update_single/1)

        do_update_singles(limit, offset + limit)
    end
  end

  def update_cards_by_set(from \\ 0) do
    Set
    |> order_by([s], asc: :id)
    |> where([s], s.id > ^from)
    |> Repo.all()
    |> Enum.each(fn set ->
      IO.inspect("updating set #{set.id} - #{set.name}")
      MkmAPI.CardsBasic.fetch(set)
    end)
  end
end
