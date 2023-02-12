defmodule KeypressWeb.HTML do
  use Phoenix.Component

  alias Phoenix.VerifiedRoutes

  alias Keypress.Schemas.Post

  alias KeypressWeb.Endpoint

  def my_page_title(nil), do: "Off By One"
  def my_page_title(string), do: "#{string} · Off By One"

  def copyright_years do
    year = DateTime.utc_now().year

    if year == 2023 do
      "2023"
    else
      "2023–#{year}"
    end
  end

  def post_description(%Post{} = post) do
    cond do
      post.title -> post.title
      post.url -> post.url
      post.body -> truncate(post.body, 100)
      :else -> "Untitled"
    end
  end

  def truncate(string, max_length) do
    if String.length(string) < max_length do
      string
    else
      string
      |> String.slice(0..(max_length - 1))
      |> String.split(" ")
      |> Enum.slice(0..-2)
      |> Enum.join(" ")
      |> then(&(&1 <> "…"))
    end
  end

  def post_edit_datetime(%Post{} = post) do
    if post.edited_at && post.published_at && DateTime.to_date(post.edited_at) != DateTime.to_date(post.published_at) do
      post.edited_at
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

  def og_image(%Post{type: :short}), do: VerifiedRoutes.static_url(Endpoint, "/images/og-image-short.webp")
  def og_image(%Post{type: :link}), do: VerifiedRoutes.static_url(Endpoint, "/images/og-image-link.webp")
  def og_image(_), do: VerifiedRoutes.static_url(Endpoint, "/images/og-image-long.webp")
end
