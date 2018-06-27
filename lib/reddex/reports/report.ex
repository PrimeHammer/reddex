defmodule Reddex.Report do
  alias Reddex.Links
  alias Reddex.ReportItem

  def send do
    get_report_items()
    |> Enum.each(&send_report_item/1)
  end

  def get_report_items do
    Links.list_pending_links()
    |> Enum.map(&link_to_report_item/1)
  end

  defp send_report_item(%ReportItem{
         link_id: link_id,
         slack_message: slack_message,
         slack_channels: slack_channels
       }) do
    slack_channels
    |> Enum.each(fn channel ->
      # TODO: Use channel variable instead of "#reddex"
      Reddex.Slack.send_message(slack_message, "#reddex")
      Reddex.Links.mark_as_sent(link_id)
    end)
  end

  defp link_to_report_item(%{tags: tags} = link) do
    %ReportItem{link_id: link.id, slack_message: slack_message(link), slack_channels: tags}
  end

  defp slack_message(%{id: id, title: title, description: description}) do
    # TODO: Full URL to Reddex
    "*#{title}*\n_#{description}_\n/links/#{id}"
  end
end
