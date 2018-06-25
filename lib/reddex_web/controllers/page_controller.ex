defmodule ReddexWeb.PageController do
  use ReddexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def sign_in(conn, _params) do
    render(conn, "sign_in.html")
  end
end
