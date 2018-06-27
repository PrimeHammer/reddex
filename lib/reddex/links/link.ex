defmodule Reddex.Links.Link do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field(:description, :string)
    field(:tags, {:array, :string})
    field(:tags_input, :string, virtual: true)
    field(:title, :string)
    field(:url, :string)
    field(:sent_to_slack_at, :date)

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :tags_input, :title, :description])
    |> validate_required([:url, :tags_input])
    |> unique_constraint(:url)
    |> tags_input_to_tags_array()
  end

  def update_changeset(link, attrs) do
    cast(link, attrs, [:title, :description, :sent_to_slack_at])
  end

  defp tags_input_to_tags_array(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{tags_input: tags_input}} ->
        tags =
          tags_input
          |> String.split(",")
          |> Enum.map(&String.trim/1)

        put_change(changeset, :tags, tags)

      _ ->
        changeset
    end
  end
end
