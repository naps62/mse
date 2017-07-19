defmodule DB.Repo.Migrations.AddMkmNameToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :mkm_name, :string
    end
  end
end
