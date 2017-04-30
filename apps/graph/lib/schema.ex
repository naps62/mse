defmodule Graph.Schema do
  alias Graph.Resolvers

  use Absinthe.Schema
  import_types Graph.Schema.Types

  query do
    @desc "Get all sets"
    field :sets, list_of(:set) do
      arg :search, :string
      resolve &Resolvers.Set.all/2
    end

    @desc "Get a single set"
    field :set, type: :set do
      arg :id, non_null(:id)
      resolve &Resolvers.Set.find/2
    end

    @desc "Get all cards for a set"
    field :cards, list_of(:card) do
      arg :set_id, non_null(:id)
      resolve &Resolvers.Card.for_set/2
    end
  end
end
