defmodule Graph.Resolvers.Set do
  def all(_args, _info) do
    {:ok, DB.Repo.all(DB.Models.Set)}
  end

  def find(%{id: id}, _info) do
    {:ok, DB.Repo.get(DB.Models.Set, id)}
  end
end
