defmodule Graph.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DB.Repo

  scalar :json, description: "JSON String" do
    parse &Poison.decode!/1
    serialize &Poison.encode!/1
  end

  scalar :utc_datetime, description: "UTC Datetime" do
    parse &to_string/1
    serialize &Ecto.DateTime.cast!/1
  end

  object :set do
    field :id, :integer
    field :name, :string

    field :mkm_code, :string
    field :gatherer_code, :string

    field :mkm_data, :json
    field :mkm_updated_at, :utc_datetime
    field :mtgjson_data, :json
    field :gatherer_code, :string
    field :mtgjson_codes, list_of(:string)
    field :gatherer_data, :json
    field :gatherer_updated_at, :utc_datetime

    field :cards, list_of(:card), resolve: assoc(:cards)
  end

  object :card do
    field :id, :integer
    field :name, :string
    field :rarity, :string
    field :image_url, :string

    field :mkm_id, :integer
    field :mkm_url, :string
    field :mkm_price_trend, :string

    field :gatherer_id, :string

    field :single_id, :integer

    field :mkm_basic_data, :json
    field :mkm_detailed_data, :json
    field :mkm_double_faced, :boolean
    field :mkm_back_face, :boolean
    field :mkm_basic_updated_at, :utc_datetime
    field :mkm_detailed_updated_at, :utc_datetime
    field :mtgjson_id, :string
    field :mtgjson_data, :json
    field :gatherer_id, :string
    field :gatherer_data, :json
    field :gatherer_updated_at, :utc_datetime

    field :set, :set
    field :single, :single
  end

  object :single do
    field :id, :integer
    field :name, :string
    field :type, :string
    field :manacost, :string
    field :ability, :string
    field :color, :string
    field :power, :integer
    field :toughness, :integer
    field :image_url, :string

    field :mkm_data, :json
    field :mkm_double_faced, :boolean
    field :mkm_back_face, :boolean
    field :mkm_updated_at, :utc_datetime
    field :mtgjson_data, :json

    field :cards, list_of(:card), resolve: assoc(:card)
  end
end
