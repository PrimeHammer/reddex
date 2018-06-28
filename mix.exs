defmodule Reddex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :reddex,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Reddex.Application, []},
      extra_applications: [:logger, :runtime_tools, :ueberauth,
                           :ueberauth_github, :readability, :timex]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:distillery, "~> 1.0"},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:sobelow, "~> 0.6.8", only: [:dev], runtime: false},
      {:plug_secex, "~> 0.1.1"},
      {:wallaby, "~> 0.19.2", [runtime: false, only: :test]},
      {:readability, "~> 0.9"},
      {:sage, "~> 0.4.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:ueberauth, "~> 0.4"},
      {:ueberauth_github, "~> 0.7"},
      {:ueberauth_testing, "~> 1.0"},
      {:slack, "~> 0.14.0"},
      {:ex_machina, "~> 2.2", only: :test},
      {:quantum, "~> 2.2"},
      {:timex, "~> 3.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
