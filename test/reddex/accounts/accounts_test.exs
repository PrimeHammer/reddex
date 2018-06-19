defmodule Reddex.AccountsTest do
  use Reddex.DataCase

  alias Reddex.Accounts

  describe "users" do
    alias Reddex.Accounts.User

    @valid_attrs %{email: "sefinko@ph.com", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "get_user_by_email/1 returns the user with given email" do
      user = user_fixture()
      assert user == Accounts.get_user_by_email("sefinko@ph.com")
    end

    test "returns an user by an email if she exists in db and is allowed" do
      user_fixture()
      auth = %{info: %{email: "sefinko@ph.com"}}
      allowed_emails = "sefinko@ph.com"
      {:ok, user_from_db} = Accounts.find_or_create(auth, allowed_emails)
      assert "some name" == user_from_db.name
    end

    test "creates an user with email and name if doesn't exist in db and is allowed" do
      auth = %{info: %{email: "sefinko@ph.com", name: "some name"}}
      allowed_emails = "sefinko@ph.com"
      {:ok, user_from_db} = Accounts.find_or_create(auth, allowed_emails)
      assert "some name" == user_from_db.name
    end

    test "returns error if user's email is not allowed with message" do
      auth = %{info: %{email: "sefinko@ph.com", name: "some name"}}
      allowed_emails = "boss@ph.com test@example.com"
      {:error, message} = Accounts.find_or_create(auth, allowed_emails)
      assert "Your email isn't allowed" == message
    end
  end
end
