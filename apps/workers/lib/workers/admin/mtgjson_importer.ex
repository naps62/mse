defmodule Workers.Admin.MtgjsonImport do
  def perform_async do
    Task.async fn ->
      IO.puts "Starting mtgjson import"
      Mtgjson.download_and_import()
      IO.puts "Finished mtgjson import"
    end
  end
end
