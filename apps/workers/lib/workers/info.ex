defmodule Workers.Info do
  use GenServer

  require Logger

  @initial_state Map.new()

  def start_link,
    do: GenServer.start_link(__MODULE__, @initial_state, name: __MODULE__)

  def get, do: GenServer.call(__MODULE__, :get)

  def start(job), do: GenServer.cast(__MODULE__, {:starting, job, self()})

  def finish(job), do: GenServer.cast(__MODULE__, {:finishing, job})

  # Server callbacks

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:starting, job, pid}, state) do
    Logger.info(fn -> "Starting: #{job}" end)

    new_state =
      state
      |> Map.put(job, pid)

    {:noreply, new_state}
  end

  def handle_cast({:finishing, job}, state) do
    Logger.info(fn -> "Ending: #{job}" end)

    new_state =
      state
      |> Map.delete(job)

    {:noreply, new_state}
  end
end
