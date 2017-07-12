defmodule Workers.Admin.MKMImport do
  require Logger

  def perform_async do
    Task.async fn ->
      Logger.info("Workers.MKMImport: Starting")
      MkmAPI.Sets.fetch
      MkmAPI.CardsBasic.fetch
      # MkmAPI.CardsDetailed.fetch(:new)
      # MkmAPI.Singles.fetch
      Logger.info("Workers.MKMImport: Finished")
    end
  end
end
