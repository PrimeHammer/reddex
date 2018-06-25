defmodule ReddexWeb.AuthControllerTest do
  use ReddexWeb.ConnCase

  setup %{conn: conn} do
    user = %Reddex.Accounts.User{name: "dhh"}
    conn = Plug.Test.init_test_session(conn, current_user: user)
    {:ok, conn: conn}
  end

  describe "delete" do
    test "logs out an user", %{conn: conn} do
      conn = delete(conn, auth_path(conn, :delete))
      assert redirected_to(conn) == "/sign_in"
    end
  end
end
