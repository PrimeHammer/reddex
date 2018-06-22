defmodule ReddexWeb.LinkControllerTest do
  use ReddexWeb.ConnCase

  alias Reddex.Links

  @create_attrs %{
    description: "some description",
    tags_input: "tag",
    title: "some title",
    url: "some url"
  }
  @invalid_attrs %{description: nil, tags: nil, title: nil, url: nil}

  def fixture(:link) do
    {:ok, link} = Links.create_link(@create_attrs)
    link
  end

  setup %{conn: conn} do
    user = %Reddex.Accounts.User{name: "dhh"}
    conn = Plug.Test.init_test_session(conn, current_user: user)
    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all links", %{conn: conn} do
      conn = get(conn, link_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Links"
    end
  end

  describe "new link" do
    test "renders form", %{conn: conn} do
      conn = get(conn, link_path(conn, :new))
      assert html_response(conn, 200) =~ "New Link"
    end
  end

  describe "create link" do
    # @tag :skip
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, link_path(conn, :create), link: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == link_path(conn, :show, id)
      # TODO: BIG TODO  How to fix this?
      # user = %Reddex.Accounts.User{name: "dhh"}
      # conn = Plug.Conn.put_session(conn, :current_user, user)

      conn = get(conn, link_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Link"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, link_path(conn, :create), link: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Link"
    end
  end
end
