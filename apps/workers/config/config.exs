use Mix.Config

config :workers, Workers.Scheduler,
  jobs: [
    {"@hourly", {Workers.Recurrent.PriceUpdater, :run, [500]}}
  ]
