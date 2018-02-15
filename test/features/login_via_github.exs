defmodule Reddex.LoginViaGithub do
  use Reddex.IntegrationCase, async: true

  test "can click and login via github", %{session: session} do
    session
    |> visit("/")
    |> assert_has(Query.css(".login-form"))
  end
end
