defmodule Reddex.Report.Mapping do
  @moduledoc """
    Map tags to slack channels
  """
  def tags_to_slack_channels(tags) do
    mapping = %{
      rubysekai: ["ruby", "ror", "rails"],
      jsbubble: ["js", "javascript"],
      elixir: ["elixir", "erlang"],
      cryptoapocalypse: ["bitcoin", "crypto", "ethereum", "smartcontracts"],
      cybersecurity: ["exploit", "security"]
    }

    tags
    |> Enum.map(&tag_to_channels(&1, mapping))
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
    |> Enum.uniq()
  end

  defp tag_to_channels(tag, mapping) do
    mapping
    |> Enum.map(&select_channels(&1, tag))
    |> Enum.filter(&channel_selected?/1)
    |> Enum.map(&format_channel/1)
  end

  defp select_channels({channel, tags}, tag), do: {channel, Enum.member?(tags, String.downcase(tag))}
  defp channel_selected?({_channel, selected?}), do: selected?
  defp format_channel({channel, _selected?}), do: "##{Atom.to_string(channel)}"
end
