defmodule Reddex.ReportTest do
  use Reddex.DataCase

  alias Reddex.{Links, Report, ReportItem}

  import Reddex.LinkFactory

  describe "generation" do
    test "generate/0 returns all pending links as ReportItems" do
      link = insert(:link, %{url: "link_url", tags_input: "javascript"})
      [%ReportItem{} = item] = Report.generate()
      assert item.slack_message =~ "/links/#{link.id}"
      assert item.slack_channel == "javascript"
    end
  end
end
