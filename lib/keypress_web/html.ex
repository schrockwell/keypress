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
      :else -> "Untitled"
    end
  end

  def post_edit_date(%Post{} = post) do
    if post.edited_at && post.published_at && DateTime.to_date(post.edited_at) != DateTime.to_date(post.published_at) do
      DateTime.to_date(post.edited_at)
    end
  end

  attr :type, :atom, required: true
  attr :icon_attrs, :global

  def post_type_icon(assigns) do
    case assigns.type do
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

  attr :rest, :global, include: ~w(href navigate)
  attr :class, :string, default: nil
  slot :inner_block, required: true

  def a(assigns) do
    ~H"""
    <.link class={["text-purple-500 transition-colors duration-300 hover:text-purple-700 underline", @class]} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block

  def h2(assigns) do
    ~H"""
    <h2 class={["text-lg border-b mb-1 pb-1 font-medium", @class]}>
      <%= render_slot(@inner_block) %>
    </h2>
    """
  end
end
