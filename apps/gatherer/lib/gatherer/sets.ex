defmodule Gatherer.Sets do
  alias DB.{SilentRepo, Models.Set}
  alias Ecto.Multi

  import Ecto.Query
  import Ecto.Changeset

  def import(data) do
    data
    |> Enum.reduce(Multi.new, &update_sets/2)
    |> SilentRepo.transaction
  end

  defp update_sets(data, multi) do
    data
    |> find_sets
    |> Enum.reduce(multi, &update_individual_set(&1, &2, data))
  end

  defp update_individual_set(set, multi, data) do
    IO.puts "Updating set #{data.code} - #{data.name}"
    Multi.update(multi, set.id, changeset(set, data))
  end

  defp find_sets(%{code: code, name: name}) do
    Set
    |> where(
      [e], e.gatherer_code == ^code or
      e.mkm_code == ^code or
      ilike(e.name, ^name) or
      ilike(e.name, ^"#{name}: Promos")
    )
    |> SilentRepo.all
  end

  defp changeset(set, data) do
    change(set)
    |> put_change(:gatherer_data, data)
    |> put_change(:gatherer_code, data[:code])
    |> put_change(:gatherer_updated_at, Timex.now)
  end
end
