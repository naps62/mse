defmodule Workers.Admin.MtgjsonImport do
  require Logger

  @job_name "[Admin Worker] Mtgjson Import"

  def perform do
    try do
      Workers.Info.start(@job_name)

      Mtgjson.download_and_import()
    rescue
      e in RuntimeError ->
        Logger.info(
          "Something went wrong in Workers.Admin.MtgjsonImport: " <> e.message
        )
    after
      Workers.Info.finish(@job_name)
    end
  end

  def perform_async do
    Task.start_link(__MODULE__, :perform, [])
  end
end
