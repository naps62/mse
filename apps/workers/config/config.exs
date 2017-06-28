use Mix.Config

config :workers, Workers.Scheduler,
  jobs: [
    {"@hourly", {Workers.Recurrent.PriceUpdater, :run, []}}
  ]

import_config "#{Mix.env}.exs"
