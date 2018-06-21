defmodule ReddexWeb.UserControllerTest do
  use ReddexWeb.ConnCase

  setup %{conn: conn} do
    user = %Reddex.Accounts.User{name: "dhh"}
    conn = assign(build_conn(), :current_user, user)
    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, user_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end
end
