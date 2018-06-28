defmodule Reddex.Repo.Migrations.AddPgSearch do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION pg_trgm")

    execute(
      """
      CREATE INDEX links_trgm_idx ON links USING GIN (to_tsvector('english', title || ' ' || description || ' ' || url))
      """
    )
  end

  def down do
    execute("DROP INDEX links_trgm_idx")
    execute("DROP EXTENSION pg_trgm")
  end
end
