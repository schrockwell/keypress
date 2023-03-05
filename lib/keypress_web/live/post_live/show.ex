defmodule KeypressWeb.PostLive.Show do
  use KeypressWeb, :live_view

  alias Keypress.Blog

  def handle_params(%{"id" => id}, uri, socket) do
    post = Blog.get_published_post!(id)

    title = if post.type in [:long, :link], do: post.title, else: ~s|"#{truncate(post.body, 50)}"|

    og_meta =
      %{
        "og:title" => title,
        "og:url" => uri,
        "og:type" => "article",
        "og:description" => truncate(Blog.post_body_as_text(post), 150),
        "og:site_name" => "Off By One",
        "og:image" => og_image(post),
        "article:author" => "Rockwell Schrock",
        "article:published_time" => og_time(post.published_at),
        "article:modified_time" => og_time(post.edited_at)
      }
      |> Map.reject(fn {_, value} -> value == nil end)

    {:noreply, assign(socket, post: post, page_title: title, og_meta: og_meta)}
  end

  defp og_time(%DateTime{} = datetime), do: datetime |> DateTime.truncate(:second) |> DateTime.to_iso8601()
  defp og_time(_), do: nil
end
