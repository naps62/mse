defmodule Workers.Mixfile do
  use Mix.Project

  def project do
    [app: :workers,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {Workers.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:my_app, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:db, in_umbrella: true},

      {:mse_mkm_api, github: "naps62/mse-mkm_api", ref: "329a8ab"},
      {:mse_gatherer, github: "naps62/mse-gatherer", ref: "6ed1454"},
      {:mse_mtgjson, github: "naps62/mse-mtgjson", ref: "9949a5a"},

      {:quantum, ">= 2.0.0-beta.1"},
      {:exq, "~> 0.9.0"},
      {:timex, "~> 3.0"},
    ]
  end
end
