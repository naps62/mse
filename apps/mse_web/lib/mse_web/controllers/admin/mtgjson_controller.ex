defmodule Mse.Web.Admin.MtgjsonController do
  use Mse.Web, :controller
  import ExAdmin.Utils

  def create(conn, _params) do
    Exq.enqueue(Exq, "default", Workers.Admin.MtgjsonImport, [])

    redirect(conn, to: admin_path())
  end
end
