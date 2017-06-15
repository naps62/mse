defmodule Workers.Admin.MtgjsonImport do
  def perform, do: Mtgjson.download_and_import()
end
