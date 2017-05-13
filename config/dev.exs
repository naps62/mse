use Mix.Config

shared_repo_config = [
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mse_dev",
  hostname: "localhost",
  pool_size: 10
]

config :db, DB.SilentRepo,
  shared_repo_config ++ [
    loggers: [],
  ]

config :db, DB.Repo,
  shared_repo_config

config :exq,
  name: Exq,
  host: "127.0.0.1",
  port: 6379,
  namespace: "exq",
  concurrency: 1000,
  queues: ["default"],
  max_retries: 5
