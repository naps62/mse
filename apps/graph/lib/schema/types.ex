defmodule Graph.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DB.Repo

  object :set do
    field :id, :integer
    field :name, :string
    field :mtgio_id, :string

    field :cards, list_of(:card), resolve: assoc(:cards)
  end

  object :card do
    field :id, :integer
    field :name, :string
    field :mtgio_id, :string
    field :image_url, :string
    field :manacost, :string
    field :set, :set
  end
end
