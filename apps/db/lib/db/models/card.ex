defmodule DB.Models.Card do
  use Ecto.Schema

  @derive [Poison.Encoder]

  schema "cards" do
    field :name, :string

    field :mtgio_id, :string
    field :mtgio_data, :map

    belongs_to :set, DB.Models.Set,
      foreign_key: :set_mtgio_id,
      references: :mtgio_id,
      type: :string

    timestamps()
  end
end
