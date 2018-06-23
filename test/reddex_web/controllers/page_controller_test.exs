defmodule ReddexWeb.PageControllerTest do
  use ReddexWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Reddex"
  end
end
