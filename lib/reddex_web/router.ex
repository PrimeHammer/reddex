defmodule ReddexWeb.Router do
  use ReddexWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(PlugSecex)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    Ueberauth.plug "/auth"
  end

  scope "/", ReddexWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/links", LinkController, only: [:index, :new, :create, :show])
    resources("/users", UserController, only: [:index])
  end

  # TODO: move me
  scope "/auth", ReddexWeb do
    pipe_through([:browser, :auth])

    get("/:provider/callback", AuthController, :callback)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReddexWeb do
  #   pipe_through :api
  # end
end
