defmodule DB.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string
      add :set_id, :integer
      add :single_id, :integer
      add :rarity, :string
      add :manacost, :string
      add :version, :string
      add :artist, :string
      add :image_url, :string

      # MKM
      add :mkm_basic_data, :map
      add :mkm_detailed_data, :map
      add :mkm_id, :integer
      add :mkm_basic_updated_at, :utc_datetime
      add :mkm_detailed_updated_at, :utc_datetime

      # mtgio
      add :mtgio_data, :map
      add :mtgio_id, :string
      add :mtgio_updated_at, :utc_datetime

      # Gatherer
      add :gatherer_data, :map
      add :gatherer_id, :string

      timestamps()
    end

    create index(:cards, [:mtgio_id])
  end
end
