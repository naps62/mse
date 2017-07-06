defmodule MseAdmin.MKMController do
  use MseAdmin, :controller

  def update(conn, _params) do
    Workers.Admin.MKMImport.perform_async()

    redirect(conn, to: "/")
  end
end
