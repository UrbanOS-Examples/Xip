defmodule Xip.MixProject do
  use Mix.Project

  def project do
    [
      app: :xip,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :snappyer]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchwarmer, "~> 0.0.2"},
      {:snappyer, "~> 1.2"},
      {:smart_city_test, "~> 0.5.3"},
      {:protobuf, "~> 0.6.3"},
      {:lz4, "~> 0.2"}
    ]
  end
end
