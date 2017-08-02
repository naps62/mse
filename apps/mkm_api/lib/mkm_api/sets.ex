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
    if !set_blacklisted(set_data) do
      case find_set(set_data) do
        nil -> SilentRepo.insert(set_changeset(%Set{}, set_data))
        set -> SilentRepo.update(set_changeset(set, set_data))
      end
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

  @blacklisted_set_names [
    ~r/^Filler Cards$/,
    ~r/ Promos$/,
    ~r/ Tokens$/,
    ~r/^TokyoMTG Products$/,
    ~r/^Tokens for MTG$/,
    ~r/^WCD /,
    ~r/ Player Cards$/,
    ~r/^MKM /,
    ~r/^Pro Tour 1996:/,
    ~r/^Starcity Games:/,
    ~r/^Rk post Products$/,
    ~r/^Salvat-Hachette/,
    ~r/^Oversized Box Toppers$/,
    ~r/^Foreign /,
    ~r/Misprints$/,
    ~r/^Promos$/,
    ~r/^Armada Comics$/,
    ~r/^Simplified Chinese Alternate Art Cards$/,
    ~r/^Renaissance$/,
    ~r/^Rinascimento$/,
    ~r/^Unstable$/,
    ~r/^GnD Cards$/,
    ~r/^Ultra-Pro Puzzle Cards$/,
    ~r/^Summer Magic$/,
    ~r/ Italian$/,
  ]
  defp set_blacklisted(%{"enName" => name}) do
    Enum.any?(@blacklisted_set_names, &Regex.match?(&1, name))
  end
end
