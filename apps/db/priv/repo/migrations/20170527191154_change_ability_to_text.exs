defmodule DB.Repo.Migrations.ChangeAbilityToText do
  use Ecto.Migration

  def change do
    alter table(:singles) do
      modify :ability, :text
    end
  end
end
