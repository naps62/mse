defmodule Mse.Admin.MKMController do
  use Mse.Admin, :controller
  import ExAdmin.Utils

  def update(conn, _params) do
    Workers.Admin.MKMImport.perform_async()

    redirect(conn, to: "/")
  end
end
