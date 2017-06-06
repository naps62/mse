defmodule MseWeb.Admin.Helpers do
  alias DB.Repo

  def count(query), do:
    query
    |> Repo.aggregate(:count, :id)
    |> Integer.to_string()
end
