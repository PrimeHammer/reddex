defmodule Reddex.Report do
  alias Reddex.Links
  alias Reddex.ReportItem

  def generate do
    Links.list_pending_links()
    |> Enum.map(&link_to_report_item/1)
  end

  defp link_to_report_item(%{id: id, tags: tags}) do
    %ReportItem{slack_message: "/links/#{id}", slack_channels: tags}
  end
end
