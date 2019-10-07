defmodule WetterWeb.Router do
  use WetterWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", WetterWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/tiles/", ImageController, :wetteronline)
    get("/trendchart/", ImageController, :trendchart)
    get("/vorhersagegrafik/", ImageController, :meteomedia)
    get("/unwetterzentrale/icons/:icon", ImageController, :unwetterzentrale)
  end

  scope "/api", WetterWeb do
    pipe_through(:api)
    get("/university_data", ApiController, :university_data)
    get("/rainradar", ApiController, :rainradar)
  end

  # Other scopes may use custom stacks.
  # scope "/api", WetterWeb do
  #   pipe_through :api
  # end
end
