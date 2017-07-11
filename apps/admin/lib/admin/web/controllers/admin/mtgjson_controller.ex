defmodule Admin.Web.MtgjsonController do
  use Admin.Web, :controller

  def update(conn, _params) do
    Workers.Admin.MtgjsonImport.perform_async()

    redirect(conn, to: "/")
  end
end
