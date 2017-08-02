defmodule Mtgjson.Singles.Finder do
  alias DB.{SilentRepo, Models.Single}

  import Ecto.Query

  # on the left, names as given by mtgjson
  # on the right, their corresponding names in our DB (% is used by SQL's LIKE function)
  @single_name_overrides %{
  }

  def find(data) do
    find_singles_by(:mtgjson_name, data["name"]) ++
      find_singles_by(:name, data["name"])
  end

  def find_singles_by(nil) do
    []
  end
  def find_singles_by(:mtgjson_name, mtgjson_name) do
    Single
    |> where([s], s.mtgjson_name == ^mtgjson_name)
    |> where([s], is_nil(s.mtgjson_data))
    |> SilentRepo.all
  end
  def find_singles_by(:name, name) do
    results = Map.get(@single_name_overrides, name, [name])
    |> Enum.map(fn(name) ->
      Single
      |> where([s], is_nil(s.mtgjson_data))
      |> where([s],
               ilike(s.name, ^"#{name}") or
               ilike(s.name, ^"#{ae_permutation(name)}")
      )
      |> SilentRepo.all
    end)

    case results do
      [] -> nil
      [single_result] -> single_result
      [_ | _] -> raise "Oops. There's not suposed to be more than one here"
    end
  end

  defp ae_permutation(name) do
    String.replace(name, "Ae", "Æ")
  end
end
