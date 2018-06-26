defmodule Reddex.Links.Comment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "comments" do
    field :link_id, :integer
    field :text, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:link_id, :user_id, :text])
    |> validate_required([:link_id, :user_id, :text])
  end
end
