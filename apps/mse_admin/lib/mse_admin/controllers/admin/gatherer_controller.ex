defmodule Mse.Admin.GathererController do
  use Mse.Admin, :controller
  import ExAdmin.Utils

  def update(conn, %{"gatherer_import" => %{"xml" => xml}}) do
    %Plug.Upload{path: path} = xml

    Workers.Admin.GathererImport.perform_async(path)

    redirect(conn, to: "/")
  end
end
