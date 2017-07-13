defmodule Workers.Admin.MKMImport do
  require Logger

  def perform do
    Logger.info("Workers.MKMImport: Starting")
    MkmAPI.Sets.fetch
    MkmAPI.CardsBasic.fetch
    MkmAPI.CardsDetailed.fetch(:new)
    MkmAPI.Singles.fetch
    Logger.info("Workers.MKMImport: Finished")
  end

  def perform_async do
    Task.start_link(__MODULE__, :perform, [])
  end
end
