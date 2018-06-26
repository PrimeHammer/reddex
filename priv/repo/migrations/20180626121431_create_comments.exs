defmodule Reddex.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :link_id, references(:links)
      add :user_id, references(:users)
      add :text, :text

      timestamps()
    end

  end
end
