defmodule DB.Repo.Migrations.RemoveMtgio do
  use Ecto.Migration

  def change do
    alter table(:sets) do
      remove :mtgio_id
      remove :mtgio_data
    end

    alter table(:cards) do
      remove :mtgio_id
      remove :mtgio_data
      remove :mtgio_updated_at
    end
  end
end
