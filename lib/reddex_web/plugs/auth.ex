defmodule ReddexWeb.Plugs.Auth do
  @moduledoc "Check if current_user is present in the session"

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    if !!get_session(conn, :current_user) || skip_auth?(conn.request_path) do
      conn
    else
      redirect_to_login(conn)
    end
  end

  defp redirect_to_login(conn) do
    conn
    |> put_session(:redirect_to, conn.request_path)
    |> Phoenix.Controller.redirect(to: "/sign_in")
    |> halt()
  end

  defp skip_auth?("/sign_in"), do: true
  defp skip_auth?("/logout"), do: true
  defp skip_auth?(_), do: false
end
