defmodule Mse.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     version: "alpha.23",
     apps: [
       :db, :workers, :mse_web, :graph, :gatherer, :mkm_api, :mtgjson
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  defp deps do
    [
      {:credo, "~> 0.7", only: [:dev, :test]},
      {:mix_docker, github: "Recruitee/mix_docker", ref: "4fc33d0"},
    ]
  end
end
