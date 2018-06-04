use Mix.Config

import_config "../apps/*/config/config.exs"

import_config "#{Mix.env()}.exs"

if Mix.env() == :prod or Mix.env() == :dev do
  import_config "mkm-prod.exs"
end

config :money,
  default_currency: :EUR,
  separator: " ",
  delimiter: " ",
  symbol: true,
  symbol_on_right: true,
  symbol_space: true
