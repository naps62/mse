# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mse_admin,
  namespace: MseAdmin,
  ecto_repos: []

# Configures the endpoint
config :mse_admin, MseAdmin.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xSb85QxDsTZAo/cCpUIZgUyV7vPPE2aBgwe3CcWz1ORMpoKIvu4PnEGfVVWej0Dy",
  render_errors: [view: MseAdmin.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MseAdmin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_admin,
  repo: DB.Repo,
  module: MseAdmin,
  modules: [
    MseAdmin.ExAdmin.Dashboard,
    MseAdmin.ExAdmin.Set,
    MseAdmin.ExAdmin.Single,
    MseAdmin.ExAdmin.Card,
  ],
  head_template: {MseAdmin.AdminView, "head.html"}

config :mse_admin, admin_basic_auth: [
  username: {:system, "ADMIN_USERNAME"},
  password: {:system, "ADMIN_PASSWORD"},
  realm: "Admin Area"
]

config :phoenix, :template_engines,
  slim: PhoenixSlime.Engine,
  slime: PhoenixSlime.Engine

config :xain, :after_callback, {Phoenix.HTML, :raw}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
