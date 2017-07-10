# This file is responsible for configuring your application
#
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# By default, the umbrella project as well as each child
# application will require this configuration file, ensuring
# they all use the same configuration. While one could
# configure all applications here, we prefer to delegate
# back to each application for organization purposes.
import_config "../apps/*/config/config.exs"

import_config "#{Mix.env}.exs"

if Mix.env == :prod or Mix.env == :dev do
  import_config "mkm-prod.exs"
end

config :money,
  default_currency: :EUR,
  separator: " ",
  delimiter: " ",
  symbol: true,
  symbol_on_right: true,
  symbol_space: true
