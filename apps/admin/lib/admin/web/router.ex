defmodule Admin.Web.Router do
  use Admin.Web, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_basic_auth do
    plug BasicAuth, use_config: {:admin, :admin_basic_auth}
  end

  scope "/", Admin.Web, as: :admin do
    pipe_through [:browser, :admin_basic_auth]

    resources "/mkm", MKMController, only: [:update], singleton: true
    resources "/gatherer", GathererController, only: [:update], singleton: true
    resources "/mtgjson", MtgjsonController, only: [:update], singleton: true
  end

  scope "/", ExAdmin do
    pipe_through [:browser, :admin_basic_auth]

    admin_routes()
  end
end
