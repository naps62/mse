defmodule Mse.Admin.MKMController do
  use Mse.Admin, :controller
  import ExAdmin.Utils

  def update(conn, _params) do
    Exq.enqueue(Exq, "default", Workers.Admin.MKMImport, [])

    redirect(conn, to: "/")
  end
end
