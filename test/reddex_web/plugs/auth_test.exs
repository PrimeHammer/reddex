defmodule ReddexWeb.Plugs.AuthTest do
  use ReddexWeb.ConnCase

  test "user is redirected when current user isn't assigned" do
    conn = build_conn() |> ReddexWeb.Plugs.Auth.call(%{})
    assert redirected_to(conn) == "/sign_in"
  end

  test "user passes through when current_user is assigned" do
    conn =
      build_conn()
      |> assign(:current_user, %Reddex.Accounts.User{})
      |> ReddexWeb.Plugs.Auth.call(%{})

    assert conn.status != 302
  end
end
