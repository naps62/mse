defmodule MseWeb.Web.Admin.Imports.SetController do
  use MseWeb.Web, :controller
  import ExAdmin.Utils

  def update(conn, _params) do
    Mtgio.Sets.import

    redirect(conn, to: admin_path)
  end
end
