use Mix.Config

config :db, DB.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mse_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
