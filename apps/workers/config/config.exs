use Mix.Config

config :workers, Workers.Scheduler,
  jobs: [
    # {"* * * * *", {Workers.Recurrent.Heartbeat, :send, []}}
  ]

import_config "#{Mix.env}.exs"
