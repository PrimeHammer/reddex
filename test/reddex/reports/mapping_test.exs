defmodule Reddex.MappingTest do
  use ExUnit.Case

  alias Reddex.Report.Mapping

  test "maps js tag to jsbubble channel" do
    ph_slack_channel = Mapping.tags_to_slack_channels(["js"])
    assert ph_slack_channel == ["#jsbubble"]
  end

  test "maps ruby tag to rubysekai channel" do
    ph_slack_channel = Mapping.tags_to_slack_channels(["ruby"])
    assert ph_slack_channel == ["#rubysekai"]
  end

  test "maps multiple elixir tags to unique elixir channel" do
    ph_slack_channel = Mapping.tags_to_slack_channels(["elixir", "elixir"])
    assert ph_slack_channel == ["#elixir"]
  end

  test "maps malformatted eRlaNg tag to elixir channel" do
    ph_slack_channel = Mapping.tags_to_slack_channels(["eRlaNg"])
    assert ph_slack_channel == ["#elixir"]
  end
end
