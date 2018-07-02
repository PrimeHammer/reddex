defmodule ReddexWeb.SearchController do
  use ReddexWeb, :controller

  def show(conn, params) do
    render(conn, "search.html", search_results: [])
  end
end
