defmodule DB.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :module, :string
      add :name, :string
      add :info, :map
      add :status, :string

      timestamps()
    end
  end
end
