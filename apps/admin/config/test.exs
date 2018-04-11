use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :admin, Admin.Web.Endpoint, http: [port: 5002]

# Print only warnings and errors during test
config :logger, level: :warn
