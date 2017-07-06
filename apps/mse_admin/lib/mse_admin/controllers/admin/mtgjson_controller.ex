defmodule MseAdmin.MtgjsonController do
  use MseAdmin, :controller

  def update(conn, _params) do
    Workers.Admin.MtgjsonImport.perform_async()

    redirect(conn, to: "/")
  end
end
