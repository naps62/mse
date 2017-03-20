defmodule MtgioImporter do
  import Ecto.Multi

  def import_sets do
    {:ok, sets} = MTG.sets

    sets
    |> Enum.reduce(Multi.new, &/add_set)
    |> Repo.transaction
  end

  def add_set(set_data, multi) do
    case find_set(set_data) do
      nil -> Multi.insert(multi, set_data.code, set_changeset(%Dataset.Set{}, set_data))
      set -> Multi.update(multi, set_data.code, set_changeset(set, set_data))
    end
  end

  def find_set(%{"code" => mtgio_id}) do
    Dataset.Set |> where(mtgio_id: mtgio_id) |> Repo.one
  end

  def set_changeset(%Dataset.Set{} = set, data) do
    change(set)
    |> put_change(:mtgio_data, data)
    |> put_change(:mtgio_id, data.code)
  end
end
