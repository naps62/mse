use Mix.Config

shared_repo_config = [
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mse_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
]

config :db, DB.SilentRepo,
  shared_repo_config ++ [
    loggers: [],
  ]

config :db, DB.Repo,
  shared_repo_config
