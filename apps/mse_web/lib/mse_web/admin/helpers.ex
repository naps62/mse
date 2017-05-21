defmodule MseWeb.Admin.Helpers do
  alias DB.Repo

  def formatted_datetime(nil), do: nil
  def formatted_datetime(datetime), do:
    datetime
    |> Timex.format("{relative}", :relative)
    |> elem(1)

  def count(query), do:
    query
    |> Repo.aggregate(:count, :id)
    |> Integer.to_string()
end
