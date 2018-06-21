defmodule Graph.Schema do
  alias Graph.Resolvers

  use Absinthe.Schema
  import_types(Graph.Schema.Types)

  query do
    @desc "Search for sets"
    field :sets, list_of(:set) do
      arg(:search, :string, default_value: "")
      arg(:limit, :integer, default_value: :infinity)
      resolve(&Resolvers.Set.search/2)
    end

    @desc "Get a single set"
    field :set, type: :set do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Set.find/2)
    end

    @desc "Search for cards"
    field :cards, list_of(:card) do
      arg(:set_id, :id)
      arg(:search, :string, default_value: "")
      arg(:limit, :integer, default_value: :infinity)
      arg(:mkm_detailed_updated_at, :string)
      resolve(&Resolvers.Card.search/2)
    end

    @desc "Get a single card"
    field :card, type: :card do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Card.find/2)
    end

    @desc "Get a batch of singles"
    field :singles, type: list_of(:single) do
      arg(:offset, non_null(:integer))
      arg(:limit, non_null(:integer))
      resolve(&Resolvers.Single.page/2)
    end

    @desc "Get a single single"
    field :single, type: :single do
      arg(:id, non_null(:id))

      resolve(&Resolvers.Single.find/2)
    end
  end
end
