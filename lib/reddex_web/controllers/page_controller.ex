defmodule ReddexWeb.PageController do
  use ReddexWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
