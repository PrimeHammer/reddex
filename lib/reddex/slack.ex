defmodule Reddex.Slack do
  use GenServer

  @name REDDEX_SLACK_SERVER

  def start_link(token) do
    {:ok, rtm} = Reddex.SlackRtm.start_link(token)
    GenServer.start_link(__MODULE__, %{rtm: rtm}, [name: @name])
  end

  def send_message(message, channel) do
    GenServer.call(@name, {:send_message, message, channel})
  end

  def handle_call({:send_message, message, channel}, _from, %{rtm: rtm} = state) do
    send rtm, {:message, message, channel}
    {:reply, :ok, state}
  end
end
