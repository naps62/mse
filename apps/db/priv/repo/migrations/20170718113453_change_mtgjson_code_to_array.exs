defmodule DB.Repo.Migrations.ChangeMtgjsonCodeToArray do
  use Ecto.Migration

  def change do
    alter table(:sets) do
      remove :mtgjson_code
      add :mtgjson_codes, {:array, :string}, default: []
    end
  end
end
