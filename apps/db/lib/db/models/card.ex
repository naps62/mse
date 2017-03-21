defmodule DB.Models.Card do
  use Ecto.Schema

  schema "cards" do
    field :name, :string

    field :mtgio_id, :string
    field :mtgio_data, :map

    timestamps
  end
end
