defmodule DB.Repo.Migrations.AddPriceTrendToCards do
  use Ecto.Migration

  def change do
    alter table(:cards) do
      add :mkm_price_trend, :integer
    end
  end
end
