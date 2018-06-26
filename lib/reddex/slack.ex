defmodule Reddex.Slack do
  @moduledoc """
  GenServer for sending messages to Slack

  ## Examples

    iex> Reddex.Slack.send_message("Message", "#random")
  """

  use GenServer

  @name REDDEX_SLACK_SERVER

  def start_link(token) do
    {:ok, pid} = Reddex.SlackRtm.start_link(token)
    GenServer.start_link(__MODULE__, %{pid: pid}, [name: @name])
  end

  def init(args) do
    {:ok, args}
  end

  def send_message(message, channel) do
    GenServer.cast(@name, {:send_message, message, channel})
  end

  def handle_cast({:send_message, message, channel}, %{pid: pid} = state) do
    send pid, {:message, message, channel}
    {:noreply, state}
  end
end
