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
    |> Enum.map(&tag_to_channel(&1, mapping))
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
    |> Enum.uniq()
  end

  defp tag_to_channel(tag, mapping) do
    Enum.map(mapping, fn element ->
      {key, values} = element

      if Enum.member?(values, String.downcase(tag)) do
        "##{Atom.to_string(key)}"
      end
    end)
  end
end
