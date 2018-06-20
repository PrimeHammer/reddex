defmodule Reddex.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :tags, {:array, :string}
      add :title, :string
      add :description, :text

      timestamps()
    end

    create unique_index(:links, [:url])
  end
end
