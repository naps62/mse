defmodule Graph.Schema.Types do
  use Absinthe.Schema.Notation

  object :set do
    field :id, :id
    field :name, :id
    field :mtgio_id, :string
  end
end
