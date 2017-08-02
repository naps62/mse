defmodule DB.Repo.Migrations.AddDoubleFacedSingleSupport do
  use Ecto.Migration

  def change do
    alter table(:singles) do
      add :mkm_double_faced, :bool, default: false
      add :mkm_back_face, :bool, default: false
    end
  end
end
