defmodule Mse.Web.Workers.Admin.UpdateSets do
  def perform, do: Mtgio.Sets.import
end
