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

  scope "/", KeypressWeb.Admin do
    pipe_through [:browser, :authenticated]

    live_session :admin, on_mount: {KeypressWeb.OnMount, :admin} do
      live "/posts", PostLive.Index, :index
      live "/posts/new/:type", PostLive.Edit, :new
      live "/posts/:id/edit", PostLive.Edit, :edit
    end
  end

  scope "/", KeypressWeb do
    pipe_through :browser

    resources "/signin", SessionController, singleton: true, only: [:show, :delete]

    live_session :public, on_mount: {KeypressWeb.OnMount, :public} do
      live "/", PostLive.Index, :index
      live "/:id", PostLive.Show, :show
    end
  end
end
