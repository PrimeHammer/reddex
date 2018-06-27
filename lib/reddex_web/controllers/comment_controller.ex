defmodule ReddexWeb.CommentController do
  use ReddexWeb, :controller

  alias Reddex.Links

  def create(conn, %{"comment" => comment_params}) do
    case Links.create_comment(comment_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: link_path(conn, :show, comment_params["link_id"]))

      {:error, _} ->
        conn
        |> put_flash(:error, "Could not create invalid comment")
        |> redirect(to: link_path(conn, :show, comment_params["link_id"]))
    end
  end
end
