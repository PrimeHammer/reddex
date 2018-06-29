defmodule Reddex.Links.Search do
  @moduledoc """
  Full text search
  """

  import Ecto.Query
  alias Reddex.Repo

  def run(query, term) do
    Repo.all(
      from(
        q in query,
        where:
          ilike(q.title, ^"#{term}%") or ilike(q.description, ^"#{term}%") or
            ilike(q.url, ^"#{term}%")
      )
    )
  end
end
