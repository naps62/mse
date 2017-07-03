defmodule Workers.Admin.GathererImport do
  def perform_async(file) do
    Task.async fn ->
      IO.puts "Starting Gatherer import"
      Gatherer.import(file)
      IO.puts "Finished Gatherer import"
    end
  end
end
