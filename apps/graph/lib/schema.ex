defmodule Graph.Schema do
  alias Graph.Resolvers

  use Absinthe.Schema
  import_types Graph.Schema.Types

  query do
    @desc "Get all sets"
    field :sets, list_of(:set) do
      arg :search, :string, default_value: ""
      resolve &Resolvers.Set.all/2
    end

    @desc "Get a single set"
    field :set, type: :set do
      arg :id, non_null(:id)
      resolve &Resolvers.Set.find/2
    end

    @desc "Search for cards"
    field :cards, list_of(:card) do
      arg :set_id, :id
      arg :search, :string, default_value: ""
      resolve &Resolvers.Card.search/2
    end

    @desc "Get a single card"
    field :card, type: :card do
      arg :id, non_null(:id)
      resolve &Resolvers.Card.find/2
    end
  end
end
