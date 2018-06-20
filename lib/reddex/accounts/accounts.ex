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
    with true <- check_email_allowed?(auth.info.email, allowed_emails),
         {:ok, user} <- find_or_create_user(auth.info.email, auth.info.name) do
      {:ok, user}
    else
      _ -> {:error, "Your email isn't allowed"}
    end
  end

  defp find_or_create_user(email, name) do
    find_or_create_user(get_user_by_email(email), email, name)
  end

  defp find_or_create_user(nil, email, name), do: create_user(%{name: name, email: email})

  defp find_or_create_user(user, _email, _name), do: {:ok, user}

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
