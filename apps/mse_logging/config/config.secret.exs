use Mix.Config

config :sentry,
  dsn: "https://178174a86f25446092281c7bc65e0370:9d08449d46f14070bb587eadfa50df29@sentry.io/181331",
  use_error_logger: true,
  environment_name: :dev,
  included_environments: [:prod],
  enable_source_code_context: true,
  root_source_code_path: File.cwd!,
  tags: %{
    env: "production"
  }

config :timber,
  api_key: "490_da0d02186a4d5c95:0b437a4f55d5923d81b86e30723c5d0f96ca7f03ffb7b2b7f89a5325c6840ae3"
