alias DB.Models.{Set, Card}
alias DB.Repo

import Ecto.Query

defmodule IExHelpers do
  def reload! do
    Mix.Task.reenable "compile.elixir"
    Mix.Task.run "compile.elixir"
  end
end

iex = IExHelpers
