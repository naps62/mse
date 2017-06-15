defmodule Mse.Web.Admin.MKMController do
  use Mse.Web, :controller
  import ExAdmin.Utils

  def update(conn, _params) do
    Exq.enqueue(Exq, "default", Workers.Admin.MKMImport, [])

    redirect(conn, to: admin_path())
  end
end
