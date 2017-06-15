defmodule Mse.Web.Workers.Admin.MtgjsonImport do
  def perform, do: Mtgjson.download_and_import()
end
