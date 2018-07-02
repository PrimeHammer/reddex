defmodule ReddexWeb.AuthController do
  @moduledoc """
  Auth controller to handle Uberauth responses
  """
  use ReddexWeb, :controller
  plug(Ueberauth)

  alias Reddex.Accounts

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> clear_session
    |> redirect(to: "/sign_in")
  end

  def callback(%{assigns: %{ueberauth_failure: failure}} = conn, _params) do
    Logger.info([
      "Github Oauth2 failure\n",
      "  failure: #{inspect(failure)}\n"
    ])
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    # TODO: move? Where? ENV variable?
    allowed_emails = "erich.kaderka@gmail.com mato.minarik@azet.sk"

    case Accounts.find_or_create(auth, allowed_emails) do
      {:ok, user} ->
        log_in(conn, user)

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  defp log_in(conn, user) do
    redirect_to = get_session(conn, :redirect_to)

    conn
    |> put_flash(:info, "Successfully authenticated.")
    |> delete_session(:redirect_to)
    |> put_session(:current_user, user)
    |> redirect(to: redirect_to || "/")
  end
end
