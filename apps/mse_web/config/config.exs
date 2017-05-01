# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mse_web,
  namespace: MseWeb,
  ecto_repos: []

# Configures the endpoint
config :mse_web, MseWeb.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xSb85QxDsTZAo/cCpUIZgUyV7vPPE2aBgwe3CcWz1ORMpoKIvu4PnEGfVVWej0Dy",
  render_errors: [view: MseWeb.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MseWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_admin,
  repo: DB.Repo,
  module: MseWeb.Web,
  modules: [
    MseWeb.Web.ExAdmin.Dashboard,
    MseWeb.Web.ExAdmin.Set,
    MseWeb.Web.ExAdmin.Card,
  ]

config :mse_web, admin_basic_auth: [
  username: {:system, "ADMIN_USERNAME"},
  password: {:system, "ADMIN_PASSWORD"},
  realm: "Admin Area"
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :xain, :after_callback, {Phoenix.HTML, :raw}
