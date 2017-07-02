defmodule Mse.Admin.GathererController do
  use Mse.Admin, :controller
  import ExAdmin.Utils

  def update(conn, %{"gatherer_import" => %{"xml" => xml}}) do
    %Plug.Upload{path: path} = xml

    Exq.enqueue(Exq, "default", Workers.Admin.GathererImport, [path])

    redirect(conn, to: "/")
  end
end
