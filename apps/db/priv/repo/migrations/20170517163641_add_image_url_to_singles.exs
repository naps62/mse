defmodule DB.Repo.Migrations.AddImageUrlToSingles do
  use Ecto.Migration

  def change do
    alter table(:singles) do
      add :image_url, :string
    end
  end
end
