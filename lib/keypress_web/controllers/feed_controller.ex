defmodule KeypressWeb.FeedController do
  alias Phoenix.Endpoint
  use KeypressWeb, :controller

  alias Keypress.Blog

  alias KeypressWeb.Endpoint

  def rss(conn, _params) do
    posts = Blog.list_published_posts(limit: 25)

    xml =
      posts
      |> build_feed()
      |> XmlBuilder.generate()

    conn
    |> put_resp_header("content-type", "application/rss+xml")
    |> resp(200, xml)
  end

  defp build_feed(posts) do
    {:rss, [version: "2.0"],
     [
       {:channel, [],
        [
          {:title, [], "Off By One"},
          {:link, [], Endpoint.url()},
          {:description, [], "Posts by Rockwell Schrock"},
          build_items(posts)
        ]}
     ]}
  end

  defp build_items(posts) do
    Enum.map(posts, fn post ->
      url = Endpoint.url() <> ~p"/#{post.id}"

      {:item, [],
       [
         {:title, [], post.title || "no title"},
         {:link, [], url},
         {:description, [], {:cdata, KeypressWeb.HTML.post_html(post)}},
         {:pubDate, [], Timex.format!(post.published_at, "{RFC822}")},
         {:guid, [isPermaLink: "true"], url}
       ]}
    end)
  end
end
