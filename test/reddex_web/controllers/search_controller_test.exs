defmodule ReddexWeb.SearchControllerTest do
  use ReddexWeb.ConnCase

  import Reddex.Factory

  setup %{conn: conn} do
    user = %Reddex.Accounts.User{name: "dhh"}
    conn = Plug.Test.init_test_session(conn, current_user: user)
    {:ok, conn: conn}
  end

  describe "search within tags for tdd" do
    test "renders link with tdd tag", %{conn: conn} do
      insert(:link, %{tags: ["tdd"], title: "taft"})
      conn = get(conn, search_path(conn, :search), q: "tdd")

      assert html_response(conn, 200) =~ "taft"
    end
  end
end
