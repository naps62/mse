defmodule Mse.Web.Admin.Gatherer.ImportsController do
  use Mse.Web, :controller
  import ExAdmin.Utils

  def create(conn, %{"gatherer_import" => %{"xml" => xml}}) do
    %Plug.Upload{path: path} = xml

    Exq.enqueue(Exq, "default", Mse.Web.Workers.Admin.GathererImport, [path])

    redirect(conn, to: admin_path())
  end
end
