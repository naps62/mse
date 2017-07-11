defmodule Admin.Web.MKMController do
  use Admin.Web, :controller

  def update(conn, _params) do
    Workers.Admin.MKMImport.perform_async()

    redirect(conn, to: "/")
  end
end
