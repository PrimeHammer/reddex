use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reddex, ReddexWeb.Endpoint,
  http: [port: 4001],
  server: true

# Wallaby config
config :reddex, :sql_sandbox, true
config :wallaby, screenshot_on_failure: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :reddex, Reddex.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER") || "postgres",
  password:  System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: "reddex_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
