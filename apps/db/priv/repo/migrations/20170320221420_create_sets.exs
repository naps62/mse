defmodule DB.Repo.Migrations.CreateSets do
  use Ecto.Migration

  def change do
    create table(:sets) do
      add :mtgio_id, :string
      add :mtgio_data, :jsonb

      timestamps()
    end

    create index(:sets, [:mtgio_id])
  end
end
