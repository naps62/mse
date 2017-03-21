defmodule Mtgio.Sets do
  alias Ecto.Multi
  import Ecto.Query
  import Ecto.Changeset

  alias DB.{Repo, Models.Set}

  def import do
    {:ok, sets} = MTG.sets

    sets
    |> Enum.reduce(Multi.new, &add_set/2)
    |> Repo.transaction
  end

  def add_set(set_data, multi) do
    case find_set(set_data) do
      nil -> Multi.insert(multi, set_data.code, set_changeset(%Set{}, set_data))
      set -> Multi.update(multi, set_data.code, set_changeset(set, set_data))
    end
  end

  def find_set(%{code: mtgio_id}) do
    Set |> where(mtgio_id: ^mtgio_id) |> Repo.one
  end

  def set_changeset(%Set{} = set, data) do
    change(set)
    |> put_change(:mtgio_data, data)
    |> put_change(:mtgio_id, data.code)
  end
end
