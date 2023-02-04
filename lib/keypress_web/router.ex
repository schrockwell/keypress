defmodule KeypressWeb.Router do
  use KeypressWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KeypressWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug KeypressWeb.ThemePlug
  end

  pipeline :authenticated do
    plug KeypressWeb.RequireAuthenticatedPlug
  end

  scope "/", KeypressWeb.Write do
    pipe_through [:browser, :authenticated]

    resources "/posts", PostController
  end

  scope "/", KeypressWeb do
    pipe_through :browser
    get "/", PageController, :home
    resources "/signin", SessionController, singleton: true, only: [:show, :delete]
    get "/:number", PostController, :show
  end
end
