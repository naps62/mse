defmodule DB.Repo.Migrations.AddManacostToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :manacost, :string
    end
  end
end
