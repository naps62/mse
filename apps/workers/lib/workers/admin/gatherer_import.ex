defmodule Workers.Admin.GathererImport do
  @job_name "[Admin Worker] Gatherer Import"

  require Logger

  def perform(file) do
    try do
      Workers.Info.start(@job_name)

      Gatherer.import(file)
    rescue
      e in RuntimeError ->
        Logger.info("Something went wrong in Workers.Admin.GathererImport: " <> e.message)
    after
      Workers.Info.finish(@job_name)
    end

  end

  def perform_async(file) do
    Task.start_link(__MODULE__, :perform, [file])
  end
end
