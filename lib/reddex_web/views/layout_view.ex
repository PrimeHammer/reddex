defmodule ReddexWeb.LayoutView do
  use ReddexWeb, :view

  def signed_in?(conn) do
    !!Plug.Conn.get_session(conn, :current_user)
  end

  def current_user(conn) do
    Plug.Conn.get_session(conn, :current_user)
  end
end
