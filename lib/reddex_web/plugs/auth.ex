defmodule ReddexWeb.Plugs.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    # TODO: Not sure about this
    # maybe be more explicit in controllers with actions
    if conn.assigns[:current_user] || conn.request_path == "/sign_in" do
      conn
    else
      conn |> redirect_to_login()
    end
  end

  defp redirect_to_login(conn) do
    conn |> Phoenix.Controller.redirect(to: "/sign_in") |> halt()
  end
end
