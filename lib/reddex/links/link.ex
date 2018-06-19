defmodule Reddex.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset


  schema "links" do
    field :description, :string
    field :tags, {:array, :string}
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :tags, :title, :description])
    |> validate_required([:url, :tags, :title, :description])
    |> unique_constraint(:url)
  end
end
