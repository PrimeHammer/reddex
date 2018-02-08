defmodule Reddex.Endpoint do
  use Phoenix.Endpoint, otp_app: :reddex
  if Application.get_env(:reddex, :sql_sandbox) do
    plug Phoenix.Ecto.SQL.Sandbox
  end
end
