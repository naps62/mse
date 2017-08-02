defmodule Mtgjson.Cards.Finder do
  alias DB.{SilentRepo}

  import Ecto.Query

  # on the left, names as given by mtgjson
  # on the right, their corresponding names in our DB (% is used by SQL's LIKE function)
  @card_name_overrides %{
  }

  def find(set, data) do
    scope = Ecto.assoc(set, :cards)

    if is_terrain?(data) do
      [find_terrain(scope, data)] |> Enum.reject(&(is_nil(&1)))
    else
      find_cards_by(scope, :mtgjson_id, data["mtgjson_id"]) ++
        find_cards_by(scope, :name, data["name"])
    end
  end

  def is_terrain?(%{"type" => "Basic Land" <> _}), do: true
  def is_terrain?(_), do: false

  # terrains from MKM come in the format "Mountain (Version 1)"
  # this version number seems to match the imageName provided by mtgjson,
  # and seems to be the only way to find a match
  # so... fingers crossed
  def find_terrain(scope, data) do
    version = case Regex.run(~r/\d+$/, data["imageName"]) do
      [first | rest] -> first
      _ -> "1"
    end
    expected_mkm_name = "#{data["name"]} (Version #{version})"

    scope
    |> where([c], c.mkm_name == ^expected_mkm_name)
    |> SilentRepo.one
  end

  def find_cards_by(_, _, nil) do
    []
  end
  def find_cards_by(scope, :mtgjson_id, mtgjson_id) do
    scope
    |> where([c], c.mtgjson_id == ^mtgjson_id)
    |> SilentRepo.all
  end
  def find_cards_by(scope, :name, name) do
    Map.get(@card_name_overrides, name, [name])
    |> Enum.map(fn(name) ->
      scope
      |> where([c],
               ilike(c.name, ^"#{name}") or
               ilike(c.name, ^"#{ae_permutation(name)}") or
               ilike(c.name, ^"#{name} (Version %)")
      )
      |> SilentRepo.all
    end)
    |> List.flatten
  end

  defp ae_permutation(name) do
    String.replace(name, "Ae", "Æ")
  end
end
