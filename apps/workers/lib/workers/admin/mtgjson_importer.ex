defmodule Workers.Admin.MtgjsonImport do
  require Logger

  def perform_async do
    Task.async fn ->
      Logger.info("Workers.MtgjsonImport: Starting")
      Mtgjson.download_and_import()
      Logger.info("Workers.MtgjsonImport: Finished")
    end
  end
end
