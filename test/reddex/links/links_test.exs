defmodule Reddex.LinksTest do
  use Reddex.DataCase

  alias Reddex.Links

  import Reddex.Factory

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
      insert(:link)
      insert(:link, %{sent_to_slack_at: Date.utc_today()})
      [link] = Links.list_pending_links()
      assert link.sent_to_slack_at == nil
    end

    test "mark_as_sent/0 sets sent_to_slack_at to current datetime" do
      link = insert(:link)
      Links.mark_as_sent(link.id)
      assert Links.list_pending_links() == []
    end
  end

  describe "comments" do
    alias Reddex.Links.Comment
    alias Reddex.Accounts

    test "create_comment/1 with valid data creates a comment" do
      {:ok, user} = Accounts.create_user(%{name: "messi", email: "messi@arg.com"})
      {:ok, link} = Links.create_link(%{url: "test", tags_input: "test soccer"})
      assert {:ok, %Comment{} = comment} = Links.create_comment(%{link_id: link.id, user_id: user.id, text: "some text"})
      assert comment.link_id == link.id
      assert comment.text == "some text"
      assert comment.user_id == user.id
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_comment(%{user_id: nil, text: nil, link_id: nil})
    end

    test "change_comment/1 returns a comment changeset" do
      assert %Ecto.Changeset{} = Links.change_comment(%Comment{})
    end
  end
end
