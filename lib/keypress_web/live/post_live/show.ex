defmodule KeypressWeb.PostLive.Show do
  use KeypressWeb, :live_view

  alias Keypress.Blog

  def handle_params(%{"id" => id}, _uri, socket) do
    post = Blog.get_published_post!(id)

    title = if post.type in [:long, :link], do: post.title, else: ~s|"#{truncate(post.body, 50)}"|

    {:noreply, assign(socket, post: post, page_title: title)}
  end
end
