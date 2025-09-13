defmodule Hello2Web.Router do
  use Hello2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: "*"
    plug Hello2Web.Plugs.RequestLogger
  end

  scope "/", Hello2Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Hello2Web do
    pipe_through :api
    
    # Основные API endpoints
    post "/", ApiController, :apiPost
    get "/", ApiController, :apiGet
    
    # Дополнительные endpoints
    get "/status", ApiController, :status
    post "/echo", ApiController, :echo
    get "/health", ApiController, :health
    
    # Дополнительные пользовательские endpoints (должны быть до resources)
    get "/users/search/:query", UserController, :search
    get "/users/search", UserController, :search_by_query
    
    # CRUD endpoints для пользователей
    resources "/users", UserController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: Hello2Web.Telemetry
    end
  end
end
