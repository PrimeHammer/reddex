defmodule ReddexWeb.LinkController do
  use ReddexWeb, :controller

  alias Reddex.Links
  alias Reddex.Links.Link
  alias Reddex.Links.Comment

  def index(conn, _params) do
    links = Links.list_links()
    render(conn, "index.html", links: links)
  end

  def new(conn, _params) do
    changeset = Links.change_link(%Link{})
    render(conn, "new.html", changeset: changeset, error_message: nil)
  end

  def create(conn, %{"link" => link_params}) do
    case Reddex.Links.Create.run(link_params) do
      {:ok, _, %{link: link}} ->
        conn
        |> put_flash(:info, "Link created successfully.")
        |> redirect(to: link_path(conn, :show, link))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, error_message: nil)

      {:error, error_message} ->
        render(
          conn,
          "new.html",
          changeset: Links.change_link(%Link{}),
          error_message: error_message
        )
    end
  end

  def show(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    changeset = Links.change_comment(%Comment{})
    render(conn, "show.html", changeset: changeset, link: link)
  end
end
