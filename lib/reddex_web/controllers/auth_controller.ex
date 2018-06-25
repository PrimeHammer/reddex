require IEx
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
    |> configure_session(drop: true)
    |> redirect(to: "/sign_in")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    # TODO: move? Where? ENV variable?
    allowed_emails = "erich.kaderka@gmail.com mato.minarik@azet.sk"

    case Accounts.find_or_create(auth, allowed_emails) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> put_session(:current_user, user)
        |> redirect(to: "/")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
