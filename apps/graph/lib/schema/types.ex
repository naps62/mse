defmodule Graph.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DB.Repo

  object :set do
    field :id, :integer
    field :name, :string

    field :mkm_code, :string
    field :gatherer_code, :string

    field :cards, list_of(:card), resolve: assoc(:cards)
  end

  object :card do
    field :id, :integer
    field :name, :string
    field :rarity, :string
    field :image_url, :string

    field :mkm_id, :integer
    field :mtgio_id, :string
    field :gatherer_id, :string

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
    field :cards, list_of(:card), resolve: assoc(:card)
  end
end
