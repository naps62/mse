defmodule Mse.Admin.Router do
  use Mse.Admin, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_basic_auth do
    # plug BasicAuth, use_config: {:mse_admin, :admin_basic_auth}
  end

  scope "/", as: :admin do
    pipe_through [:browser, :admin_basic_auth]

    resources "/mkm", Mse.Admin.MKMController, only: [:update], singleton: true
    resources "/gatherer", Mse.Admin.GathererController, only: [:update], singleton: true
    resources "/mtgjson", Mse.Admin.MtgjsonController, only: [:update], singleton: true
  end

  scope "/", ExAdmin do
    pipe_through [:browser, :admin_basic_auth]

    admin_routes()
  end
end
