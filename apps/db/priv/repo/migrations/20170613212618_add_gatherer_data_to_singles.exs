defmodule DB.Repo.Migrations.AddGathererDataToSingles do
  use Ecto.Migration

  def change do
    alter table(:singles) do
      add :gatherer_data, :map
    end
  end
end
