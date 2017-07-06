defmodule Mse.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     version: "alpha.59",
     apps: [
       :mse_proxy,
       :mse_web,
       :mse_admin,
       :db,
       :workers,
       :mtgjson,
       :gatherer,
       :mkm_api,
       :graph,
       :mse_logging,
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
