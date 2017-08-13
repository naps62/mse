defmodule Gatherer.Sets do
  alias DB.{SilentRepo, Models.Set}

  import Ecto.Query
  import Ecto.Changeset

  def import(data) do
    data
    |> Enum.each(&update_sets/1)
  end

  defp update_sets(data) do
    data
    |> find_sets
    |> Enum.each(&update_individual_set(&1, data))
  end

  defp update_individual_set(set, data) do
    IO.puts "Updating set #{set.id} #{data.code} - #{data.name}"

    set
    |> changeset(data)
    |> SilentRepo.update
  end

  defp find_sets(%{code: code, name: name}) do
    Set
    |> where(
      [e], (e.gatherer_code == ^code) or
      (is_nil(e.gatherer_code) and e.mkm_code == ^code) or
      (is_nil(e.gatherer_code) and ilike(e.name, ^name)) or
      (is_nil(e.gatherer_code) and ilike(e.name, ^"#{name}: Promos"))
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
