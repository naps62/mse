defmodule Workers.Logger do
  alias DB.Models.Job
  alias DB.Repo

  def job_start(params \\ %{}) do
    Job.create_changeset(%Job{}, params)
    |> Repo.insert!
  end

  def job_end(log, params \\ %{}) do
    Job.update_changeset(log, params)
    |> Repo.update!
  end
end
