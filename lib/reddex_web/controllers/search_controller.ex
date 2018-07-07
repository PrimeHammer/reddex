defmodule ReddexWeb.SearchController do
  use ReddexWeb, :controller

  alias Reddex.Links.{Search, Link}

  def search(conn, params) do
    search_results = Search.run(Link, params["q"])
    render(conn, "search.html", search_results: search_results)
  end
end
