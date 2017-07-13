defmodule Workers.Admin.GathererImport do
  require Logger

  def perform(file) do
    Logger.info("Workers.GathererImport: Starting")
    Gatherer.import(file)
    Logger.info("Workers.GathererImport: Finished")
  end

  def perform_async(file) do
    Task.start_link(__MODULE__, :perform, [file])
  end
end
