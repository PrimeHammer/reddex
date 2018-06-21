defmodule ReddexWeb.Plugs.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    if conn.assigns[:current_user] do
      conn
    else
      conn |> Phoenix.Controller.redirect(to: "/sign_in") |> halt()
    end
  end
end
