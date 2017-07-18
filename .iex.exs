alias DB.Models.{Set, Card, Single}
alias DB.Repo

import Ecto.Query
import Ecto.Changeset

defmodule IExHelpers do
  def reload! do
    Mix.Task.reenable "compile.elixir"
    Mix.Task.run "compile.elixir"
  end
end

iex = IExHelpers
