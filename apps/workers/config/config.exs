use Mix.Config

config :workers, Workers.Scheduler,
  jobs: [
    # {"* * * * *", {Workers.Recurrent.Heartbeat, :send, []}}
  ]
