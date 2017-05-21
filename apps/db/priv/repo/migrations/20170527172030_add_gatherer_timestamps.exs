defmodule DB.Repo.Migrations.AddGathererTimestamps do
  use Ecto.Migration

  def change do
    alter table(:sets) do
      add :gatherer_updated_at, :utc_datetime
    end

    alter table(:cards) do
      add :gatherer_updated_at, :utc_datetime
    end
  end
end
