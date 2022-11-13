defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug(CORSPlug, origin: "*")
    plug(:accepts, ["json"])
  end

  pipeline :auth do
    plug(CORSPlug, origin: "*")
    plug(:accepts, ["json"])
    plug(ApiWeb.JWTAuthPlug)
  end

  scope "/api", ApiWeb do
    pipe_through(:auth)

    get("/", AuthController, :get)
    delete("/", AuthController, :logout)
    scope "/users" do
        put "/:id", UserController, :update
        put "/", UserController, :update_user_without_id
        delete "/:id", UserController, :delete
        delete "/", UserController, :delete_user_without_id
        get "/:id", UserController, :show
        get "/", UserController, :index
      end

      scope "/workingtimes" do
        post "/", WorkingtimeController, :create
        put "/:id", WorkingtimeController, :update
        delete "/:id", WorkingtimeController, :delete
        get "/", WorkingtimeController, :index
        get "/:id", WorkingtimeController, :show
      end

      scope "/clocks" do
        post "/", ClockController, :create
        put "/:id", ClockController, :update
        delete "/:id", ClockController, :delete
        get "/", ClockController, :index
        get "/last_two", ClockController, :get_two_last_clocks
        get "/:id", ClockController, :show

      end
  end

  scope "/api/auth", ApiWeb do
    pipe_through(:api)

    post("/login", AuthController, :login)
    post("/register", UserController, :create)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through [:fetch_session, :protect_from_forgery]

  #     live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
  #   end
  # end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  # if Mix.env() == :dev do
  #   scope "/dev" do
  #     pipe_through [:fetch_session, :protect_from_forgery]

  #     forward "/mailbox", Plug.Swoosh.MailboxPreview
  #   end
  # end
end
