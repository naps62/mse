defmodule DB.Repo.Migrations.AddMkmURLToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :mkm_url, :string
    end
  end
end
