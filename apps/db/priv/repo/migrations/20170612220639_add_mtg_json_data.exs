defmodule DB.Repo.Migrations.AddMtgJsonData do
  use Ecto.Migration

  def change do
    alter table(:sets) do
      add :mtgjson_code, :string
      add :mtgjson_data, :map
    end

    alter table(:singles) do
      add :mtgjson_name, :string
      add :mtgjson_data, :map
    end

    alter table(:cards) do
      add :mtgjson_id, :string
      add :mtgjson_data, :map
    end
  end
end
