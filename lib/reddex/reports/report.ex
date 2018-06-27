defmodule Reddex.Report do
  alias Reddex.Links
  alias Reddex.ReportItem

  def generate do
    Links.list_pending_links()
    |> Enum.map(&link_to_report_item/1)
  end

  defp link_to_report_item(%{tags: tags} = link) do
    %ReportItem{slack_message: slack_message(link), slack_channels: tags}
  end

  defp slack_message(%{id: id, title: title, description: description}) do
    # TODO: Full URL to Reddex
    "*#{title}*\n_#{description}_\n/links/#{id}"
  end
end
