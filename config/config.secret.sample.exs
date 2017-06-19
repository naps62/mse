config :sentry,
  dsn: "SENTRY_DSN_HERE"
  use_error_logger: true,
  environment_name: :prod,
  included_environments: [:prod],
  enable_source_code_context: true,
  root_source_code_path: File.cwd!,
  tags: %{
    env: "production"
  }
