defmodule ReddexWeb.CommentControllerTest do
  use ReddexWeb.ConnCase

  alias Reddex.Links

  @update_attrs %{link_id: 43, text: "some updated text", user_id: 43}
  @invalid_attrs %{link_id: nil, text: nil, user_id: nil}

  def fixture(:comment) do
    {:ok, comment} = Links.create_comment(@create_attrs)
    comment
  end

  setup %{conn: conn} do
    user = %Reddex.Accounts.User{name: "dhh"}
    conn = Plug.Test.init_test_session(conn, current_user: user)
    {:ok, conn: conn}
  end

  describe "create comment" do
    test "redirects to link show when data is valid", %{conn: conn} do
      {:ok, link} = Links.create_link(%{url: "http://example.com", tags_input: "test"})
      create_attrs = %{link_id: link.id, text: "some comment about link", user_id: 42}
      conn = post conn, link_comment_path(conn, :create, link.id),
        comment: create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == link_path(conn, :show, link.id)

      conn = get conn, link_path(conn, :show, link.id)
      assert html_response(conn, 200) =~ "some comment about link"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      {:ok, link} = Links.create_link(%{url: "http://example.com", tags_input: "test"})
      conn = post conn, link_comment_path(conn, :create, link.id), comment: @invalid_attrs
      assert redirected_to(conn) == link_path(conn, :show, link.id)
      conn = get conn, link_path(conn, :show, link.id)
      assert html_response(conn, 200) =~ "Invalid comment"
    end
  end


  describe "update comment" do
    setup [:create_comment]

    @tag :skip
    #test "redirects when data is valid", %{conn: conn, comment: comment} do
    #  conn = put conn, comment_path(conn, :update, comment), comment: @update_attrs
    #  assert redirected_to(conn) == comment_path(conn, :show, comment)

    #  conn = get conn, comment_path(conn, :show, comment)
    #  assert html_response(conn, 200) =~ "some updated text"
    #end

    @tag :skip
    #test "renders errors when data is invalid", %{conn: conn, comment: comment} do
    #  conn = put conn, comment_path(conn, :update, comment), comment: @invalid_attrs
    #  assert html_response(conn, 200) =~ "Edit Comment"
    #end
  end

  defp create_comment(_) do
    comment = fixture(:comment)
    {:ok, comment: comment}
  end
end
