defmodule KeypressWeb.PostLive.Index do
  use KeypressWeb, :live_view

  alias Keypress.Blog

  def mount(_, _, socket) do
    {:ok, assign(socket, posts: Blog.list_published_posts(), page_title: "Home")}
  end
end
