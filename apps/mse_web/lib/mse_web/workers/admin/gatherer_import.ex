defmodule Mse.Web.Workers.Admin.GathererImport do
  def perform(file), do: Gatherer.import(file)
end
