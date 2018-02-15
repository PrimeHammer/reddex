defmodule ReddexWeb.UserController do
  use ReddexWeb, :controller

  alias Reddex.Accounts
  alias Reddex.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end
end
