defmodule DB.Models.Set do
  use Ecto.Schema

  @derive {Poison.Encoder, only: [:name, :mtgio_id]}

  schema "sets" do
    field :name, :string

    field :mkm_id, :integer
    field :mkm_data, :map
    field :mkm_name, :string
    field :mkm_code, :string
    field :mkm_updated_at, Timex.Ecto.DateTime
    field :mkm_cards_updated_at, Timex.Ecto.DateTime

    field :mtgio_id, :string
    field :mtgio_data, :map

    field :gatherer_data, :map
    field :gatherer_code, :string
    field :gatherer_updated_at, Timex.Ecto.DateTime

    has_many :cards, DB.Models.Card

    timestamps()
  end
end
