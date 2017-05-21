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
    case find_set(data) do
      nil ->
        IO.puts "Warning: could not find set #{data.code} - #{data.name}"
        multi
      set ->
        IO.puts "Updating set #{data.code} - #{data.name}"
        Multi.update(multi, set.id, changeset(set, data))
    end
  end

  defp find_set(%{code: code, name: name}) do
    Set
    |> where([e], e.gatherer_code == ^code or ilike(e.name, ^name))
    |> SilentRepo.one
  end

  defp changeset(set, data) do
    change(set)
    |> put_change(:gatherer_data, data)
    |> put_change(:gatherer_code, data[:code])
    |> put_change(:gatherer_updated_at, Timex.now)
  end
end
