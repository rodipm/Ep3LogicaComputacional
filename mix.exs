defmodule Ep3Logica.MixProject do
  use Mix.Project

  def project do
    [
      app: :ep3_logica,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Docs
      name: "Ep3Logica",
      source_url: "https://github.com/rodipm/Ep3LogicaComputacional",
      docs: [
        main: "Ep3Logica",
        extas: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false}
    ]
  end
end
