defmodule DB.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string

      add :set_mtgio_id, :string
      add :mtgio_id, :string
      add :mtgio_data, :jsonb

      timestamps()
    end

    create index(:cards, [:mtgio_id])
  end
end
