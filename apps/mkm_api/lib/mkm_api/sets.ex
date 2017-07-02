defmodule MkmAPI.Sets do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Set}

  def fetch do
    {:ok, sets} = MKM.expansions

    sets
    |> Enum.each(&add_or_update_set/1)
  end

  def parse do
    Set
    |> SilentRepo.all
    |> Enum.each(&parse_set/1)
  end


  defp add_or_update_set(set_data) do
    case find_set(set_data) do
      nil -> SilentRepo.insert(set_changeset(%Set{}, set_data))
      set -> SilentRepo.update(set_changeset(set, set_data))
    end
  end

  defp find_set(%{"idExpansion" => mkm_id}) do
    Set |> where(mkm_id: ^mkm_id) |> SilentRepo.one
  end

  defp parse_set(%Set{mkm_data: mkm_data} = set) do
    SilentRepo.update(set_changeset(set, mkm_data))
  end

  def set_changeset(set, data) do
    change(set)
    |> put_change(:mkm_data, data)
    |> put_change(:mkm_id, data["idExpansion"])
    |> put_change(:mkm_code, data["abbreviation"])
    |> put_change(:mkm_name, data["enName"])
    |> put_change(:name, data["enName"])
    |> put_change(:mkm_updated_at, Timex.now)
    |> validate_required([:mkm_id, :mkm_data])
  end
end
