defmodule DB.Models.Card do
  use Ecto.Schema

  @derive [Poison.Encoder]

  schema "cards" do
    field :name, :string
    field :rarity, :string
    field :version, :string
    field :artist, :string
    field :image_url, :string

    field :mkm_basic_data, :map
    field :mkm_detailed_data, :map
    field :mkm_id, :integer
    field :mkm_url, :string
    field :mkm_basic_updated_at, Timex.Ecto.DateTime
    field :mkm_detailed_updated_at, Timex.Ecto.DateTime
    field :mkm_price_trend, Money.Ecto.Type

    field :mtgio_data, :map
    field :mtgio_id, :string
    field :mtgio_updated_at, Timex.Ecto.DateTime

    field :gatherer_data, :map
    field :gatherer_id, :string
    field :gatherer_updated_at, Timex.Ecto.DateTime

    belongs_to :set, DB.Models.Set
    belongs_to :single, DB.Models.Single

    timestamps()
  end
end
