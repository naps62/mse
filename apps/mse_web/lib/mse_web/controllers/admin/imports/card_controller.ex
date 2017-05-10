defmodule Mse.Web.Admin.Imports.CardController do
  use Mse.Web, :controller
  import ExAdmin.Utils

  def update(conn, _params) do
    Exq.enqueue(Exq, "default", Mse.Web.Workers.Admin.UpdateCards, [])

    redirect(conn, to: admin_path)
  end
end
