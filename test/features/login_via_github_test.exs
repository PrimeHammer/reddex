defmodule Reddex.LoginViaGithub do
  use Reddex.IntegrationCase, async: true

  test "can click and login via github", %{session: session} do
    session
    |> visit("/sign_in")
    |> assert_has(Query.text("Login with Github"))
  end
end
