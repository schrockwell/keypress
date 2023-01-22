defmodule KeypressWeb.PostController do
  use KeypressWeb, :controller

  alias Keypress.Blog

  def show(conn, %{"number" => number}) do
    render(conn, :show, post: Blog.get_published_post_by_number!(number))
  end
end
