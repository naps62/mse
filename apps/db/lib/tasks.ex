defmodule DB.Release.Tasks do
  @desc "Run migrations"
  def migrate do
    {:ok, _} = Application.ensure_all_started(:db)

    path = Application.app_dir(:db, "priv/repo/migrations")

    Ecto.Migrator.run(DB.Repo, path, :up, all: true)
  end
end
