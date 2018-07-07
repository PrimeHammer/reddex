defmodule Reddex.Report do
  @moduledoc false

  alias Reddex.Links
  alias Reddex.Report.Mapping
  alias Reddex.ReportItem

  def send do
    Enum.each(get_report_items(), &send_report_item/1)
  end

  def get_report_items do
    Enum.map(Links.list_pending_links(), &link_to_report_item/1)
  end

  defp send_report_item(%ReportItem{
         link_id: link_id,
         slack_message: slack_message,
         slack_channels: slack_channels
       }) do
    Enum.each(slack_channels, fn channel ->
      Reddex.Slack.send_message(slack_message, channel)
      Reddex.Links.mark_as_sent(link_id)
    end)
  end

  defp link_to_report_item(%{tags: tags} = link) do
    %ReportItem{
      link_id: link.id,
      slack_message: slack_message(link),
      slack_channels: Mapping.tags_to_slack_channels(tags)
    }
  end

  defp slack_message(%{id: id, title: title, description: description}) do
    host_url = System.get_env("HOST_URL")
    "*#{title}*\n_#{description}_\n#{host_url}/links/#{id}"
  end
end
