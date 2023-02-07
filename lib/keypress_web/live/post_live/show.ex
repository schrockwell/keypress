defmodule KeypressWeb.PostLive.Show do
  use KeypressWeb, :live_view

  alias Keypress.Blog

  def handle_params(%{"number" => number}, _uri, socket) do
    {:noreply, assign(socket, post: Blog.get_published_post_by_number!(number))}
  end
end
