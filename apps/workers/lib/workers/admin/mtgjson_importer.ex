defmodule Workers.Admin.MtgjsonImport do
  require Logger

  def perform do
    Logger.info("Workers.MtgjsonImport: Starting")
    Mtgjson.download_and_import()
    Logger.info("Workers.MtgjsonImport: Finished")
  end

  def perform_async do
    Task.start_link(__MODULE__, :perform, [])
  end
end
