defmodule Workers.WorkersSupervisor do
  use Supervisor

  @name __MODULE__

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = []
  end
end
