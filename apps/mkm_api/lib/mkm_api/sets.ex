defmodule MkmAPI.Sets do
  alias Ecto.Multi
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Set}

  def fetch do
    {:ok, sets} = MKM.expansions

    sets
    |> Enum.reduce(Multi.new, &add_or_update_set/2)
    |> SilentRepo.transaction
  end

  def parse do
    Set
    |> SilentRepo.all
    |> Enum.reduce(Multi.new, &parse_set/2)
    |> SilentRepo.transaction
  end


  defp add_or_update_set(%{"idExpansion" => mkm_set_id} = set_data, multi) do
    case find_set(set_data) do
      nil -> Multi.insert(multi, mkm_set_id, set_changeset(%Set{}, set_data))
      set -> Multi.update(multi, mkm_set_id, set_changeset(set, set_data))
    end
  end

  defp find_set(%{"idExpansion" => mkm_id}) do
    Set |> where(mkm_id: ^mkm_id) |> SilentRepo.one
  end

  defp parse_set(%Set{id: id, mkm_data: mkm_data} = set, multi) do
    Multi.update(multi, id, set_changeset(set, mkm_data))
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
