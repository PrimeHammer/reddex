defmodule ReddexWeb.Plugs.Auth do
  @moduledoc "Check if current_user is present in the session"

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    # TODO: Not sure about this
    # maybe be more explicit in controllers with actions
    if get_session(conn, :current_user) || conn.request_path == "/sign_in" || conn.request_path == "/logout" do
      conn
    else
      redirect_to_login(conn)
    end
  end

  defp redirect_to_login(conn) do
    conn |> Phoenix.Controller.redirect(to: "/sign_in") |> halt()
  end
end
