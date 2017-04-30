defmodule Graph.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DB.Repo

  object :set do
    field :id, :id
    field :name, :string
    field :mtgio_id, :string

    field :cards, list_of(:card), resolve: assoc(:cards)
  end

  object :card do
    field :id, :id
    field :name, :string
    field :set, :set
  end
end
