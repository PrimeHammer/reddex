defmodule Reddex.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Reddex.Repo

  alias Reddex.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc "get user by email or raise an exception"
  def get_user_by_email(email), do: Repo.get_by(User, email: email)

  @doc "finds an account or creates new one"
  def find_or_create(auth, allowed_emails) do
    cond do
      check_email_allowed?(auth.info.email, allowed_emails) &&
        (user_from_db = get_user_by_email(auth.info.email)) ->
          {:ok, user_from_db}

      check_email_allowed?(auth.info.email, allowed_emails) ->
        {:ok, %User{}} = create_user(%{name: auth.info.name, email: auth.info.email})

      true ->
        {:error, "Your email isn't allowed"}
    end
  end

  @doc "Check if an email is in allowed emails"
  def check_email_allowed?(email, allowed_emails) do
    allowed_emails
    |> String.split(" ")
    |> Enum.member?(email)
  end

  @doc "Creates an user"
  def create_user(attrs \\ {}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
