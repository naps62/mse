defmodule Mtgjson.Cards.Finder do
  alias DB.{SilentRepo}

  import Ecto.Query

  def find(set, data) do
    scope = Ecto.assoc(set, :cards)

    find_card_by(scope, :mtgjson_id, data["mtgjson_id"]) ||
      find_card_by(scope, :name, data["name"])
  end

  def find_card_by(_, _, nil) do
    nil
  end
  def find_card_by(scope, :mtgjson_id, mtgjson_id) do
    scope
    |> where([c], c.mtgjson_id == ^mtgjson_id)
    |> SilentRepo.one
  end
  def find_card_by(scope, :name, name) do
    scope
    |> where([c], c.name == ^name)
    |> SilentRepo.one
  end
end
