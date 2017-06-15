defmodule Mse.Web.Router do
  use Mse.Web, :router
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

  pipeline :exq do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
    plug ExqUi.RouterPlug, namespace: "exq"
  end

  forward "/graphql", Absinthe.Plug, schema: Graph.Schema

  scope "/admin", as: :admin do
    pipe_through [:browser, :admin_basic_auth]

    scope "/gatherer", as: :gatherer do
      resources "/imports", Mse.Web.Admin.GathererController, only: [:create]
    end

    scope "/mtgjson", as: :mtgjson do
      resources "/imports", Mse.Web.Admin.MtgjsonController, only: [:create]
    end
  end

  scope "/admin", ExAdmin do
    pipe_through [:browser, :admin_basic_auth]

    admin_routes()
  end

  scope "/exq", ExqUi do
    pipe_through [:admin_basic_auth, :exq]

    forward "/", RouterPlug.Router, :index
  end

  scope "/", Mse.Web do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
