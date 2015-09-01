defmodule Uber.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :uber,
     version: @version,
     description: description,
     package: package,
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  defp description do
    """
    Utilities for working with the UBER hypermedia format in Elixir.
    """
  end

  defp package do
    [contributors: ["pete gamache"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/gamache/uber.ex"}]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end
end
