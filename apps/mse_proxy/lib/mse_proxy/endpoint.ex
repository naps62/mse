defmodule MseProxy.Endpoint do
  use Phoenix.Endpoint, otp_app: :mse_proxy

  plug MseProxy.Plug, %{
    "admin.lvh.me" => Admin.Web.Endpoint,
    "admin.mtgsear.ch" => Admin.Web.Endpoint,
    "default" => MseWeb.Endpoint
  }
end
