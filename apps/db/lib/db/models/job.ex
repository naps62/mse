defmodule DB.Models.Job do
  use Ecto.Schema

  import Ecto.Changeset

  @derive [Poison.Encoder]

  schema "jobs" do
    field :module, :string
    field :name, :string
    field :info, :map, default: %{}
    field :status, :string, default: "started"

    timestamps()
  end

  def create_changeset(job, params \\ %{}) do
    job
    |> cast(params, [:module, :name])
    |> validate_required([:module, :name])
  end

  def update_changeset(job, params \\ %{}) do
    job
    |> cast(params, [:name, :info])
    |> validate_required([:info])
  end
end
