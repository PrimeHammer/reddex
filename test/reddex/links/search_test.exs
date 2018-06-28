defmodule Reddex.Links.SearchTest do
  use Reddex.DataCase

  alias Reddex.Links
  alias Reddex.Links.Search

  import Reddex.Factory

  test "searches for git in title" do
    insert(:link)
    insert(:link, title: "Github flow")
    [link] = Search.run(Reddex.Links.Link, "git")
    assert link.title == "Github flow"
  end
end
