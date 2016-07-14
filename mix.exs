defmodule APIServer.Mixfile do
  use Mix.Project

  def project do
    [app: :api_server,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  def application do
    [applications: [:logger, :cowboy, :plug, :rethinkdb]]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:plug, "~> 1.1"},
      {:poison, "~> 2.0"},
      {:csv, "~> 1.4.2"},
      {:rethinkdb, "~> 0.4.0"},
      {:corsica, "~> 0.4"}
    ]
  end
end
