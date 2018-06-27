defmodule Reddex.Repo.Migrations.AddSentToSlackAtToLinks do
  use Ecto.Migration

  def change do
    alter table("links") do
      add :sent_to_slack_at, :date
    end

    create index("links", [:sent_to_slack_at])
  end
end
