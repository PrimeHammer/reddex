defmodule ReddexWeb.LinkView do
  use ReddexWeb, :view

  def readable_tags(tags) do
    tags
    |> Enum.map(fn t -> "#{t}, " end)
    |> Enum.join()
    |> String.slice(0..-3)
  end

  def commented_at(timestamp) do
    Timex.from_now(timestamp)
  end
end
