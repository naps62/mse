defmodule Mtgsearch.MkmApi.Fix.NewImageUrls do
  alias DB.Models.{Single, Card}
  alias DB.Repo

  import Ecto.Query

  def run do
    update_singles
    update_cards_by_set
  end

  def update_singles do
    Single
    |> Repo.all()
    |> Enum.each(&MkmAPI.Singles.update_single/1)
  end

  def update_cards_by_set do
    Set
    |> Repo.all()
    |> Enum.each(&MkmAPI.CardsBasic.fetch/1)
  end
end
