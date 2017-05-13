defmodule DB.Repo.Migrations.CreateSets do
  use Ecto.Migration

  def change do
    create table(:sets) do
      add :name, :string

      # MKM
      add :mkm_data, :map
      add :mkm_id, :integer
      add :mkm_name, :string
      add :mkm_code, :string
      add :mkm_updated_at, :utc_datetime
      add :mkm_cards_updated_at, :utc_datetime

      # Mtgio
      add :mtgio_id, :string
      add :mtgio_data, :map

      # Gatherer
      add :gatherer_data, :map
      add :gatherer_code, :string

      timestamps()
    end

    create index(:sets, [:mtgio_id])
  end
end
