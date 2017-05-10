defmodule Mse.Web.Admin.Imports.SetController do
  use Mse.Web, :controller
  import ExAdmin.Utils

  def update(conn, _params) do
    Exq.enqueue(Exq, "default", Mse.Web.Workers.Admin.UpdateSets, [])

    redirect(conn, to: admin_path)
  end
end
