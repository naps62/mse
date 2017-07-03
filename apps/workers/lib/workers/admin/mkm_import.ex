defmodule Workers.Admin.MKMImport do
  def perform_async do
    Task.async fn ->
      IO.puts "Starting MKM import"
      MkmAPI.Sets.fetch
      MkmAPI.CardsBasic.fetch
      MkmAPI.CardsDetailed.fetch(:new)
      MkmAPI.Singles.fetch
      IO.puts "Finished MKM import"
    end
  end
end
