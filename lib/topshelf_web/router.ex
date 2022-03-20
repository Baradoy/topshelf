defmodule TopshelfWeb.Router do
  use TopshelfWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TopshelfWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TopshelfWeb do
    pipe_through :browser

    live_session :default do
      live "/", BottleLive.Index, :index

      live "/shelves", ShelfLive.Index, :index
      live "/shelves/new", ShelfLive.Index, :new
      live "/shelves/:id/edit", ShelfLive.Index, :edit

      live "/shelves/:id", ShelfLive.Show, :show
      live "/shelves/:id/show/edit", ShelfLive.Show, :edit

      live "/bottles", BottleLive.Index, :index
      live "/bottles/new", BottleLive.Index, :new
      live "/bottles/:id/edit", BottleLive.Index, :edit

      live "/bottles/:id", BottleLive.Show, :show
      live "/bottles/:id/show/edit", BottleLive.Show, :edit
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", TopshelfWeb do
  #   pipe_through :api
  # end

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

      live_dashboard "/dashboard", metrics: TopshelfWeb.Telemetry
    end
  end

  defp auth(conn, _opts) do
    if !(Application.get_env(:topshelf, :environment) in [:dev, :test]) do
      username = System.fetch_env!("AUTH_USERNAME")
      password = System.fetch_env!("AUTH_PASSWORD")
      Plug.BasicAuth.basic_auth(conn, username: username, password: password)
    else
      conn
    end
  end
end
