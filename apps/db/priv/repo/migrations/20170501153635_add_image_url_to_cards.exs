defmodule DB.Repo.Migrations.AddImageUrlToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :image_url, :string
    end
  end
end
