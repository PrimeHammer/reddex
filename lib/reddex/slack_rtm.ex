defmodule Reddex.SlackRtm do
  @moduledoc """
  Slack Real Time Messaging
  See: https://hexdocs.pm/slack/Slack.html
  """

  use Slack

  def start_link(token) do
    Slack.Bot.start_link(__MODULE__, [], token)
  end

  def handle_connect(_, state), do: {:ok, state}
  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    send_message(text, channel, slack)
    {:ok, state}
  end

  def handle_info(_, _, state), do: {:ok, state}
end
