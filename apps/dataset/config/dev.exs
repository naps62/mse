use Mix.Config

config :dataset, Dataset.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mse_dev",
  hostname: "localhost",
  pool_size: 10
