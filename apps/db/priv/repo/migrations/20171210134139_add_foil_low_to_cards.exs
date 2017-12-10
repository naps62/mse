defmodule DB.Repo.Migrations.AddFoilLowToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :mkm_foil_low, :integer
    end
  end
end
