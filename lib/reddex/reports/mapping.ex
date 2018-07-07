defmodule Reddex.Report.Mapping do
  @moduledoc """
    Map tags to slack channels
  """
  def tags_to_slack_channels(tags) do
    mapping = %{
      rubysekai: ["ruby", "ror", "rails"],
      jsbubble: ["js", "javascript"],
      elixir: ["elixir", "erlang"]
    }

    tags
    |> Enum.map(fn tag ->
      is_tag_in_mapping?(tag, mapping)
    end)
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
    |> Enum.uniq()
  end

  defp is_tag_in_mapping?(tag, mapping) do
    Enum.map(mapping, fn element ->
      {key, values} = element

      if Enum.member?(values, String.downcase(tag)) do
        Atom.to_string(key)
      end
    end)
  end
end
