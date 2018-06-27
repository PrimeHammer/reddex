defmodule Reddex.ReportTest do
  use Reddex.DataCase

  alias Reddex.{Report, ReportItem}

  import Reddex.LinkFactory

  describe "generation" do
    test "returns all pending links as ReportItems" do
      link = insert(:link, %{tags: ["javascript"]})

      [%ReportItem{} = item] = Report.generate()

      assert item.slack_message =~ "/links/#{link.id}"
      assert item.slack_channels == ["javascript"]
    end
  end
end
