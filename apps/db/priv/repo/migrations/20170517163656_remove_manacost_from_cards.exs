defmodule DB.Repo.Migrations.RemoveManacostFromCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      remove :manacost
    end
  end
end
