defmodule MseAdmin.Helpers do
  alias DB.Repo

  def count(query), do:
    query
    |> Repo.aggregate(:count, :id)
    |> Integer.to_string()

  def relative_date(nil), do: ""
  def relative_date(datetime) do
    {:ok, str} = Timex.format(datetime, "{relative}", :relative)
    str
  end
end
