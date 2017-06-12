defmodule DB.Models.Single do
  use Ecto.Schema

  schema "singles" do
    field :name, :string
    field :name_pt, :string
    field :type, :string
    field :manacost, :string
    field :ability, :string
    field :color, :string
    field :power, :integer
    field :toughness, :integer
    field :image_url, :string

    field :mkm_data, :map
    field :mkm_id, :integer
    field :mkm_updated_at, Timex.Ecto.DateTime

    field :gatherer_data, :map

    field :mtgjson_name, :string
    field :mtgjson_data, :map

    has_many :cards, DB.Models.Card

    timestamps()
  end
end
