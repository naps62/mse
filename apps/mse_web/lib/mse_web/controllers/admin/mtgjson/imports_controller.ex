defmodule Mse.Web.Admin.Mtgjson.ImportsController do
  use Mse.Web, :controller
  import ExAdmin.Utils

  def create(conn, _params) do
    Exq.enqueue(Exq, "default", Mse.Web.Workers.Admin.MtgjsonImport, [])

    redirect(conn, to: admin_path())
  end
end
