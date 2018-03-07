defmodule Workers.Admin.MKMImport do
  require Logger

  @job_name "[Admin Worker] MKM Import"

  def perform do
    try do
      Workers.Info.start(@job_name)

      MkmAPI.Sets.fetch()
      MkmAPI.CardsBasic.fetch()
      MkmAPI.CardsDetailed.fetch(:new)
      MkmAPI.Singles.fetch()
    rescue
      e in RuntimeError ->
        Logger.info("Something went wrong in Workers.Admin.MKMImport: ")
    after
      Workers.Info.finish(@job_name)
    end
  end

  def perform_async do
    Task.start_link(__MODULE__, :perform, [])
  end
end
