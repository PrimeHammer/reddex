defmodule Reddex.Links.Link do

  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field(:description, :string)
    field(:tags, {:array, :string})
    field(:tags_input, :string, virtual: true)
    field(:title, :string)
    field(:url, :string)

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
