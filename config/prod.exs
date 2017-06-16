use Mix.Config

shared_repo_config = [
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 10,
  ssl: false
]

config :db, DB.SilentRepo,
  shared_repo_config

config :db, DB.Repo,
  shared_repo_config
