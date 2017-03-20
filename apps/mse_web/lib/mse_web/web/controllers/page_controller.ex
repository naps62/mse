defmodule MseWeb.Web.PageController do
  use MseWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
