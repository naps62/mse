defmodule Mse.Web.Application do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      # Start the endpoint when the application starts
      supervisor(Mse.Web.Endpoint, []),
      # Start your own worker by calling: Mse.Web.Worker.start_link(arg1, arg2, arg3)
      # worker(Mse.Web.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mse.Web.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
