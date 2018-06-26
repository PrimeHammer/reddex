defmodule Reddex.LinksTest do
  use Reddex.DataCase

  alias Reddex.Links

  import Reddex.LinkFactory

  describe "links" do
    alias Reddex.Links.Link

    @valid_attrs %{
      description: "some description",
      tags_input: "tag1, tag2",
      title: "some title",
      url: "some url"
    }
    @invalid_attrs %{description: nil, tags: nil, title: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Links.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link_fixture()
      [link] = Links.list_links()
      assert link.description == "some description"
      assert link.tags == ["tag1", "tag2"]
      assert link.title == "some title"
      assert link.url == "some url"
    end

    test "get_link!/1 returns the link with given id" do
      link_fixture = link_fixture()
      link = Links.get_link!(link_fixture.id)
      assert link.description == "some description"
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Links.create_link(@valid_attrs)
      assert link.description == "some description"
      assert link.tags == ["tag1", "tag2"]
      assert link.title == "some title"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(@invalid_attrs)
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Links.change_link(link)
    end

    test "list_pending_links/0 returns link waiting to be reported" do
      insert(:link) # %{sent_to_slack: false}
      pending = Links.list_pending_links()
      assert List.length(pending) == 1
    end
  end
end
