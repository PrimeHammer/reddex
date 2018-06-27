defmodule Reddex.LinkFactory do
  @moduledoc false

  use ExMachina.Ecto, repo: Reddex.Repo

  def link_factory do
    %Reddex.Links.Link{
      description: sequence(:description, &"Description #{&1}"),
      tags_input: "phoenix, elixir"
    }
  end
end
