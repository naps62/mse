defmodule DB.Repo.Migrations.DropGathererDataFromSingles do
  use Ecto.Migration

  def change do
    alter table(:singles) do
      remove :gatherer_data
    end
  end
end
