defmodule Mse.Web.Admin.MKMController do
  use Mse.Web, :controller
  import ExAdmin.Utils

  def update(conn, _params) do
    # Exq.enqueue(Exq, "default", Workers.Admin.MKMImport, [])
    Task.async fn ->
      IO.puts "Sets"
      MkmAPI.Sets.fetch
      IO.puts "CardsBasic"
      MkmAPI.CardsBasic.fetch
      IO.puts "CardsDetailed"
      MkmAPI.CardsDetailed.fetch(:new)
      IO.puts "Done"
    end

    redirect(conn, to: admin_path())
  end
end
