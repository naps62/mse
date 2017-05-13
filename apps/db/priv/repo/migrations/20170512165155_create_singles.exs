defmodule DB.Repo.Migrations.CreateSingles do
  use Ecto.Migration

  def change do
    create table(:singles) do
      add :name, :string
      add :name_pt, :string
      add :type, :string
      add :manacost, :string
      add :ability, :string
      add :color, :string
      add :power, :integer
      add :toughness, :integer

      add :mkm_data, :map, null: false
      add :mkm_id, :integer
      add :mkm_updated_at, :utc_datetime

      timestamps()
    end
  end
end
