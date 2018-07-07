defmodule Reddex.ReportTest do
  use Reddex.DataCase

  alias Reddex.Report
  alias Reddex.ReportItem

  import Reddex.Factory

  describe "generation" do
    test "returns all pending links as ReportItems" do
      insert(:link, %{tags: ["javascript"]})

      [%ReportItem{} = item] = Report.get_report_items()

      assert item.slack_channels == ["jsbubble"]
    end

    test "formats slack message" do
      link = insert(:link, %{title: "Title", description: "Test", tags: ["test"]})

      [%ReportItem{} = item] = Report.get_report_items()

      assert item.slack_message == "*Title*\n_Test_\n/links/#{link.id}"
    end
  end
end
