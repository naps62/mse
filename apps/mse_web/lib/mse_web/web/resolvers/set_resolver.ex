defmodule MseWeb.Web.SetResolver do
  def all(_args, _info) do
    {:ok, DB.Repo.all(DB.Models.Set)}
  end
end
