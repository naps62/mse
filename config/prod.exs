use Mix.Config

config :db, DB.Repo,
  adapter: Ecto.Adapters.Postgres,
  host: "db",
  username: {:system, "POSTGRES_USER"},
  password: {:system, "POSTGRES_PASSWORD"},
  database: "mse",
  pool_size: {:system, "POOL_SIZE"},
  ssl: true
