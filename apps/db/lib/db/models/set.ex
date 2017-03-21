defmodule DB.Models.Set do
  use Ecto.Schema

  schema "sets" do
    field :mtgio_id, :string
    field :mtgio_data, :map

    timestamps
  end
end
