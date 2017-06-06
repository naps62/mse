defmodule Mse.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     version: "alpha.12",
     apps: [
       :db, :mse_web, :graph, :mtgio, :gatherer, :mkm_api
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
