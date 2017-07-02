defmodule Mse.Admin.MtgjsonController do
  use Mse.Admin, :controller
  import ExAdmin.Utils

  def update(conn, _params) do
    Exq.enqueue(Exq, "default", Workers.Admin.MtgjsonImport, [])

    redirect(conn, to: "/")
  end
end
