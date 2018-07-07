defmodule Reddex.Links.SearchTest do
  use Reddex.DataCase

  alias Reddex.Links.Search

  import Reddex.Factory

  test "searches for git in title" do
    insert(:link)
    insert(:link, title: "Github flow")
    [link] = Search.run(Reddex.Links.Link, "git")
    assert link.title == "Github flow"
  end

  test "searches for git in description" do
    insert(:link)
    insert(:link, description: "Github flow")
    [link] = Search.run(Reddex.Links.Link, "git")
    assert link.description == "Github flow"
  end

  test "searches for git in url" do
    insert(:link)
    insert(:link, url: "Github flow")
    [link] = Search.run(Reddex.Links.Link, "git")
    assert link.url == "Github flow"
  end
end
