defmodule Workers.Admin.GathererImport do
  require Logger

  def perform_async(file) do
    Task.async fn ->
      Logger.info("Workers.GathererImport: Starting")
      Gatherer.import(file)
      Logger.info("Workers.GathererImport: Finished")
    end
  end
end
