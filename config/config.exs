# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :reddex, ecto_repos: [Reddex.Repo]

# Configures the endpoint
config :reddex, ReddexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0P86qy81s8e/mdHDNRT1kJaA478pZXPfyKhgAtt3vE0DmZw7GrGGN5IufIduThYC",
  render_errors: [view: ReddexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Reddex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

# TODO: Move to prod.exs
config :reddex, Reddex.Scheduler,
  jobs: [
    {"* * * * *", {Reddex.Report, :send, []}}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
