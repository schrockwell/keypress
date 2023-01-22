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

  pipeline :author do
    plug :author_basic_auth
  end

  scope "/", KeypressWeb do
    pipe_through :browser
    get "/", PageController, :home
    get "/all", PostController, :index
    get "/:number", PostController, :show
  end

  scope "/write/", KeypressWeb do
    pipe_through [:browser, :author]
  end

  defp author_basic_auth(conn, _opts) do
    username = ""
    password = System.fetch_env!("AUTHOR_PASSWORD")
    Plug.BasicAuth.basic_auth(conn, username: username, password: password)
  end
end
