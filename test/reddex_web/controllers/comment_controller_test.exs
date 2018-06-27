defmodule ReddexWeb.CommentControllerTest do
  use ReddexWeb.ConnCase

  alias Reddex.Links
  alias Reddex.Accounts

  setup %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{name: "dhh", email: "dhh@basecamp.com"})
    conn = Plug.Test.init_test_session(conn, current_user: user)
    {:ok, conn: conn, user: user}
  end

  describe "create comment" do
    test "redirects to link show when data is valid", %{conn: conn, user: user} do
      {:ok, link} = Links.create_link(%{url: "http://example.com", tags_input: "test"})
      create_attrs = %{link_id: link.id, text: "some comment about link", user_id: user.id}
      conn = post(conn, link_comment_path(conn, :create, link.id), comment: create_attrs)

      assert redirected_to(conn) == link_path(conn, :show, link.id)

      conn = get(conn, link_path(conn, :show, link.id))
      assert html_response(conn, 200) =~ "some comment about link"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      {:ok, link} = Links.create_link(%{url: "http://example.com", tags_input: "test"})
      invalid_create_attrs = %{link_id: link.id, text: nil, user_id: user.id}
      conn = post(conn, link_comment_path(conn, :create, link.id), comment: invalid_create_attrs)

      assert redirected_to(conn) == link_path(conn, :show, link.id)
      conn = get(conn, link_path(conn, :show, link.id))
      assert html_response(conn, 200) =~ "Could not create invalid comment"
    end
  end
end
