defmodule Mse.Mixfile do
  use Mix.Project


  def project do
    [apps_path: "apps",
     version: "alpha.9",
     apps: [
       :db, :mse_web, :graph, :mtgio,
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options.
  #
  # Dependencies listed here are available only for this project
  # and cannot be accessed from applications inside the apps folder
  defp deps do
    [
      {:credo, "~> 0.7", only: [:dev, :test]},
      {:mix_docker, github: "Recruitee/mix_docker", ref: "4fc33d0"},
    ]
  end
end
