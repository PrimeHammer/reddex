defmodule ReddexWeb.PageControllerTest do
  use ReddexWeb.ConnCase

  setup %{conn: conn} do
    user = %Reddex.Accounts.User{name: "dhh"}
    conn = assign(build_conn(), :current_user, user)
    {:ok, conn: conn}
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
