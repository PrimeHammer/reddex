defmodule Reddex.Links.Link do
  @moduledoc false

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
    |> validate_required([:url, :tags])
    |> unique_constraint(:url)
  end
end
