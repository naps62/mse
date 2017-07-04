defmodule MseProxy.Endpoint do
  use Phoenix.Endpoint, otp_app: :mse_proxy

  plug MseProxy.Plug, %{
    "admin.lvh.me" => Mse.Admin.Endpoint,
    "admin.mtgsear.ch" => Mse.Admin.Endpoint,
    "default" => MseWeb.Endpoint
  }
end
