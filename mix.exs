defmodule Mse.Mixfile do
  use Mix.Project

  def project do
    [apps_path: "apps",
     version: "beta.10-12-2017",
     apps: [
       :proxy,
       :mse_web,
       :admin,
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
      {:distillery, "1.3.4"}
    ]
  end
end
