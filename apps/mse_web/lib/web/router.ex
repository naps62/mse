defmodule MseWeb.Web.Router do
  use MseWeb.Web, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_basic_auth do
    plug BasicAuth, use_config: {:mse_web, :admin_basic_auth}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/graphql", Absinthe.Plug, schema: Graph.Schema

  # Other scopes may use custom stacks.
  scope "/api", MseWeb.Web do
    pipe_through :api

    resources "/sets", API.SetController, only: [:index, :show]
  end

  scope "/admin", ExAdmin do
    pipe_through :browser
    pipe_through :admin_basic_auth

    admin_routes()
  end

  scope "/", MseWeb.Web do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
