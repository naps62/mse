defmodule Mtgjson.Sets.Finder do
  alias DB.{SilentRepo, Models.Set}

  import Ecto.Query

  # on the left, names as given by mtgjson
  # on the right, their corresponding names in our DB
  @set_name_overrides %{
    "Duels of the Planeswalkers" => ["Duels of the Planeswalkers Decks"],
    "Fourth Edition" => [
      "Fourth Edition",
      "Fourth Edition: Alternate",
      "Fourth Edition: Black Bordered"
    ],
    "The Dark" => ["The Dark", "The Dark Italian"],
    "Legends" => ["Legends", "Legends Italian"],
    "Modern Masters 2017 Edition" => ["Modern Masters 2017"],
    "Duel Decks Anthology, Jace vs. Chandra" => ["Duel Decks: Anthology"],
    "Duel Decks Anthology, Garruk vs. Liliana" => ["Duel Decks: Anthology"],
    "Duel Decks Anthology, Elves vs. Goblins" => ["Duel Decks: Anthology"],
    "Duel Decks Anthology, Divine vs. Demonic" => ["Duel Decks: Anthology"],
    "European Land Program" => ["Euro Lands"],
    "Chronicles" => ["Chronicles", "Chronicles: Japanese"]
  }

  def find(mtgjson_code, data) do
    # if Enum.member?(~w|JOU|, mtgjson_code) do
    already_matched_sets(mtgjson_code) ++ newly_matched_sets(data)
    # else
    #   []
    # end
  end

  def already_matched_sets(mtgjson_code) do
    Set
    |> where([s], fragment("? = ANY (?)", ^mtgjson_code, s.mtgjson_codes))
    |> SilentRepo.all()
  end

  def newly_matched_sets(data) do
    [
      sets_matching_by(:mkm_id, data["mkm_id"]),
      sets_matching_by(:mkm_name, data["mkm_name"]),
      sets_matching_by(:name, data["name"]),
      sets_matching_by(:alternative_names, data["alternativeNames"])
    ]
    |> List.flatten()
  end

  def sets_matching_by(_, nil) do
    # return empty result list
    where(Set, [_], 1 == 2)
    |> SilentRepo.all()
  end

  def sets_matching_by(:mkm_id, mkm_id) do
    where(Set, [s], s.mkm_id == ^mkm_id)
    |> SilentRepo.all()
  end

  def sets_matching_by(:mkm_name, mkm_name) do
    where(Set, [s], ilike(s.mkm_name, ^"#{mkm_name}"))
    |> SilentRepo.all()
  end

  def sets_matching_by(:name, name) do
    names = Map.get(@set_name_overrides, name, [name])

    names
    |> Enum.map(fn name ->
      Set
      |> where([s], ilike(s.name, ^"#{name}"))
      |> SilentRepo.all()
    end)
    |> List.flatten()
  end

  def sets_matching_by(:alternative_names, names) do
    names
    |> Enum.map(fn name ->
      Set
      |> where([s], ilike(s.name, ^"#{name}"))
      |> SilentRepo.all()
    end)
    |> List.flatten()
  end
end
