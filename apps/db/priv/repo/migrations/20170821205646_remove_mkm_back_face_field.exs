defmodule DB.Repo.Migrations.RemoveMkmBackFaceField do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      remove :mkm_back_face
    end

    alter table(:singles) do
      remove :mkm_back_face
    end
  end
end
