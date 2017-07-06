defmodule MseProxy.Endpoint do
  use Phoenix.Endpoint, otp_app: :mse_proxy

  plug MseProxy.Plug, %{
    "admin.lvh.me" => MseAdmin.Endpoint,
    "admin.mtgsear.ch" => MseAdmin.Endpoint,
    "default" => MseWeb.Endpoint
  }
end
