defmodule ReddexWeb.PageController do
  use ReddexWeb, :controller

  def sign_in(conn, _params) do
    render(conn, "sign_in.html")
  end
end
