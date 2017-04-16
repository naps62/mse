defmodule Graph.Schema do
  alias Graph.Resolvers

  use Absinthe.Schema
  import_types Graph.Schema.Types

  query do
    field :sets, list_of(:set) do
      resolve &Resolvers.Set.all/2
    end
  end
end
