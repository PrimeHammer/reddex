defmodule ReddexWeb.CommentController do
  use ReddexWeb, :controller

  alias Reddex.Links
  alias Reddex.Links.Comment

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
end
