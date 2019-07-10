use Mix.Config

shared_repo_config = [
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mse_dev",
  hostname: "localhost",
  pool_size: 10
]

config :db,
       DB.SilentRepo,
       shared_repo_config ++
         [
           loggers: []
         ]

config :db, DB.Repo, shared_repo_config
