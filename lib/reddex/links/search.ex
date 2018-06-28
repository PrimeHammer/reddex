require IEx

defmodule Reddex.Links.Search do
  @moduledoc """
  Full text search
  """

  import Ecto.Query
  alias Reddex.Repo

  def run(query, term) do
    where(
      query,
      fragment(
        "to_tsvector('english', title || ' ' || description || ' ' || url) @@ to_tsquery(?)",
        ^prefix_search(term)
      )
    )
    |> Repo.all()
  end

  # Replace empty characters and prefix with *
  defp prefix_search(term), do: String.replace(term, ~r/\W/u, "") <> ":*"
end
