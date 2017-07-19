defmodule DB.Repo.Migrations.AddDoubleFacedCardSupport do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :mkm_double_faced, :bool, default: false
      add :mkm_back_face, :bool, default: false
    end
  end
end
