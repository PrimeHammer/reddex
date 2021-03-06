defmodule Reddex.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Reddex.Repo

  def link_factory do
    %Reddex.Links.Link{
      url: sequence(:url, &"URL #{&1}"),
      description: sequence(:description, &"Description #{&1}"),
      tags_input: "phoenix, elixir"
    }
  end

  def user_factory do
    %Reddex.Accounts.User{
      email: sequence(:email, &"user-#{&1}@example.com"),
      name: sequence(:name, &"User #{&1}")
    }
  end
end
