defmodule Proxy.Plug do
  @behaviour Plug

  def init(hosts), do: hosts

  def call(conn, hosts) do
    endpoint =
      if Map.has_key?(hosts, conn.host) do
        Map.fetch!(hosts, conn.host)
      else
        Map.fetch!(hosts, "default")
      end

    endpoint.call(conn, endpoint.init(nil))
  end
end
