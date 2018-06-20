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

  scope "/", ReddexWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources "/links", LinkController, only: [:index, :new, :create, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReddexWeb do
  #   pipe_through :api
  # end
end
