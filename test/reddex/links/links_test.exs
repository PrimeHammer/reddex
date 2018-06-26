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

    @valid_attrs %{link_id: 42, text: "some text", user_id: 42}
    @update_attrs %{link_id: 43, text: "some updated text", user_id: 43}
    @invalid_attrs %{link_id: nil, text: nil, user_id: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Links.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Links.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Links.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Links.create_comment(@valid_attrs)
      assert comment.link_id == 42
      assert comment.text == "some text"
      assert comment.user_id == 42
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Links.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Links.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.link_id == 43
      assert comment.text == "some updated text"
      assert comment.user_id == 43
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Links.update_comment(comment, @invalid_attrs)
      assert comment == Links.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Links.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Links.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Links.change_comment(comment)
    end
  end
end
