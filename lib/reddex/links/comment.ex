defmodule Reddex.Links.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field(:text, :string)

    belongs_to(:user, Reddex.Accounts.User)
    belongs_to(:link, Reddex.Links.Link)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:link_id, :user_id, :text])
    |> validate_required([:link_id, :user_id, :text])
  end
end
