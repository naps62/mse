defmodule DB.Models.Set do
  use Ecto.Schema

  schema "sets" do
    field :name, :string

    field :mtgio_id, :string
    field :mtgio_data, :map

    has_many :cards, DB.Models.Card,
      foreign_key: :set_mtgio_id,
      references: :mtgio_id

    timestamps
  end
end
