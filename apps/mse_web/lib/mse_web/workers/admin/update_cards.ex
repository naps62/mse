defmodule Mse.Web.Workers.Admin.UpdateCards do
  def perform, do: Mtgio.Cards.import
end
