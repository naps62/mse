defmodule MseWeb.Web.Schema do
  alias MseWeb.Web.SetResolver

  use Absinthe.Schema
  import_types MseWeb.Web.Schema.Types

  query do
    field :sets, list_of(:set) do
      resolve &SetResolver.all/2
    end
  end
end
