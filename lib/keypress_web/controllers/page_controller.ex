defmodule KeypressWeb.PageController do
  use KeypressWeb, :controller

  alias Keypress.Blog

  def home(conn, _params) do
    render(conn, :home, posts: Blog.list_published_posts(limit: 20))
  end
end
