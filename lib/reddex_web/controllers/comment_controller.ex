defmodule ReddexWeb.CommentController do
  use ReddexWeb, :controller

  alias Reddex.Links
  alias Reddex.Links.Comment

  def index(conn, _params) do
    comments = Links.list_comments()
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = Links.change_comment(%Comment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Links.create_comment(comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: link_path(conn, :show, comment_params["link_id"]))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Could not create invalid comment")
        |> redirect(to: link_path(conn, :show, comment_params["link_id"]))
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Links.get_comment!(id)
    render(conn, "show.html", comment: comment)
  end

  def edit(conn, %{"id" => id}) do
    comment = Links.get_comment!(id)
    changeset = Links.change_comment(comment)
    render(conn, "edit.html", comment: comment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Links.get_comment!(id)

    case Links.update_comment(comment, comment_params) do
      {:ok, comment} ->
        conn
        |> put_flash(:info, "Comment updated successfully.")
        #|> redirect(to: comment_path(conn, :show, comment))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", comment: comment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Links.get_comment!(id)
    {:ok, _comment} = Links.delete_comment(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    #|> redirect(to: comment_path(conn, :index))
  end
end
