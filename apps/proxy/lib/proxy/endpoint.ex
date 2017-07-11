defmodule Proxy.Endpoint do
  use Phoenix.Endpoint, otp_app: :proxy

  plug Proxy.Plug, %{
    "admin.lvh.me" => Admin.Web.Endpoint,
    "admin.mtgsear.ch" => Admin.Web.Endpoint,
    "default" => MseWeb.Endpoint
  }
end
