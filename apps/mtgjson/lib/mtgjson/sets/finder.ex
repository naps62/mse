defmodule Mtgjson.Sets.Finder do
  alias DB.{SilentRepo, Models.Set}

  import Ecto.Query

  def find(mtgjson_code, data) do
    already_matched_sets(mtgjson_code) ++
      newly_matched_sets(data)
  end

  def already_matched_sets(mtgjson_code) do
    Set
    |> where([s], fragment("? = ANY (?)", ^mtgjson_code, s.mtgjson_codes))
    |> SilentRepo.all
  end

  def newly_matched_sets(data) do
    [
      sets_matching_by(:mkm_id, data["mkm_id"]),
      sets_matching_by(:mkm_name, data["mkm_name"]),
      sets_matching_by(:name, data["name"]),
    ]
    |> Enum.map(&SilentRepo.all/1)
    |> List.flatten
  end

  def sets_matching_by(_, nil) do
    # return empty result list
    where(Set, [_], 1 == 2)
  end
  def sets_matching_by(:mkm_id, mkm_id) do
    where(Set, [s], s.mkm_id == ^mkm_id)
  end
  def sets_matching_by(:mkm_name, mkm_name) do
    where(Set, [s], ilike(s.mkm_name, ^"#{mkm_name}"))
  end
  def sets_matching_by(:name, name) do
    where(Set, [s], ilike(s.name, ^"#{name}"))
  end
end
