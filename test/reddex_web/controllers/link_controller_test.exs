defmodule ReddexWeb.LinkControllerTest do
  use ReddexWeb.ConnCase

  alias Reddex.Links

  import Mock

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
    test "redirects to show when data is valid", %{conn: conn} do
      with_mock Reddex.Links.Create, [
        run: fn(params) -> 
          {:ok, link} = Links.create_link(params)
          {:ok, link, %{link: link}}
        end
      ] do
        conn = post(conn, link_path(conn, :create), link: @create_attrs)

        assert %{id: id} = redirected_params(conn)
        assert redirected_to(conn) == link_path(conn, :show, id)

        conn = get(conn, link_path(conn, :show, id))
        assert html_response(conn, 200) =~ "Show Link"
      end
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, link_path(conn, :create), link: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Link"
    end
  end
end
