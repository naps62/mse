use Mix.Config

config :exq,
  name: Exq,
  host: "redis",
  port: 6379,
  namespace: "exq",
  concurrency: 1000,
  queues: ["default"],
  max_retries: 5,
  password: {:system, "REDIS_PASSWORD"}
