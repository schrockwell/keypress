defmodule KeypressWeb.HTML do
  use Phoenix.Component

  alias Keypress.Schemas.Post

  def copyright_years do
    year = DateTime.utc_now().year

    if year == 2023 do
      "2023"
    else
      "2023–#{year}"
    end
  end

  def post_title(%Post{} = post) do
    cond do
      post.title -> post.title
      post.url -> post.url
      post.body -> nil
      :else -> "(untitled)"
    end
  end

  def post_type(%Post{} = post) do
    cond do
      post.url -> :link
      post.title -> :long
      :else -> :short
    end
  end

  attr :post, Post, required: true
  attr :icon_attrs, :global

  def post_icon(assigns) do
    case post_type(assigns.post) do
      :link -> ~H"<Heroicons.link {@icon_attrs} />"
      :long -> ~H"<Heroicons.document_text {@icon_attrs} />"
      :short -> ~H"<Heroicons.chat_bubble_left {@icon_attrs} />"
    end
  end

  def date(%DateTime{} = datetime) do
    if datetime.year == DateTime.utc_now().year do
      Calendar.strftime(datetime, "%B %-d")
    else
      Calendar.strftime(datetime, "%B %-d, %Y")
    end
  end
end
