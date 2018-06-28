defmodule ReddexWeb.AuthControllerTest do
  use ReddexWeb.ConnCase

  import Reddex.Factory

  setup %{conn: conn} do
    user = %Reddex.Accounts.User{name: "dhh"}
    conn = Plug.Test.init_test_session(conn, current_user: user)
    {:ok, conn: conn}
  end

  describe "delete" do
    test "logs out an user", %{conn: conn} do
      conn = delete(conn, auth_path(conn, :delete))
      assert redirected_to(conn) == "/sign_in"
      refute Plug.Conn.get_session(conn, :current_user)
    end
  end

  describe "callback" do
    test "redirects user to original URL", %{conn: conn} do
      insert(:user, %{email: "mato.minarik@azet.sk"})

      conn =
        conn
        |> assign(:ueberauth_auth, %{info: %{name: "Matej", email: "mato.minarik@azet.sk"}})
        |> put_session(:redirect_to, "/links/1")
        |> get(auth_path(conn, :callback, "testing"))

      assert redirected_to(conn) == "/links/1"
      refute Plug.Conn.get_session(conn, :redirect_to)
    end
  end
end
