defmodule MseWeb.Web.Router do
  use MseWeb.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MseWeb.Web do
    pipe_through :browser # Use the default browser stack

    resources "/sets", SetController, only: [:index, :show]
    get "/", SetController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", MseWeb.Web do
    pipe_through :api

    resources "/sets", API.SetController, only: [:index, :show]
  end
end
