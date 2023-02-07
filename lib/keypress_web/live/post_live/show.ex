defmodule KeypressWeb.PostLive.Show do
  use KeypressWeb, :live_view

  alias Keypress.Blog

  def handle_params(%{"id" => id}, _uri, socket) do
    {:noreply, assign(socket, post: Blog.get_published_post!(id))}
  end
end
