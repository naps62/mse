defmodule Graph.Schema do
  alias Graph.Resolvers

  use Absinthe.Schema
  import_types Graph.Schema.Types

  query do
    @desc "Get all sets"
    field :sets, list_of(:set) do
      resolve &Resolvers.Set.all/2
    end

    @desc "Get a single set"
    field :set, type: :set do
      arg :id, non_null(:id)
      resolve &Resolvers.Set.find/2
    end
  end
end
