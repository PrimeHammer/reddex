defmodule Reddex.IntegrationCase do
  @moduledoc """
  Setup Wallaby for Reddex
  https://hashrocket.com/blog/posts/integration-testing-phoenix-with-wallaby
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias Reddex.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import ReddexWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Reddex.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.sandbox().mode(Reddex.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Reddex.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
