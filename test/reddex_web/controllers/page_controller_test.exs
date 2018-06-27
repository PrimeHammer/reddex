defmodule ReddexWeb.PageControllerTest do
  use ReddexWeb.ConnCase

  setup %{conn: conn} do
    user = %Reddex.Accounts.User{name: "dhh"}
    conn = Plug.Test.init_test_session(conn, current_user: user)
    {:ok, conn: conn}
  end

  test "GET /sign_in", %{conn: conn} do
    conn = get(conn, "/sign_in")
    assert html_response(conn, 200) =~ "Login with Github"
  end
end
