use Mix.Config

config :db, DB.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: {:system, "POOL_SIZE"},
  ssl: true
