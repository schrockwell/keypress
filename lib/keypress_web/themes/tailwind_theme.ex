defmodule KeypressWeb.TailwindTheme do
  use KeypressWeb, :html

  alias Keypress.Schemas.Post

  embed_templates "tailwind/*"

  attr :rest, :global
  slot :inner_block, required: true

  def a(assigns) do
    ~H"""
    <.link class="text-purple-500 transition-colors duration-300 hover:text-purple-700 underline" {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  attr :post, Post, required: true

  def post_body(assigns) do
    ~H"""
    <%= raw(Earmark.as_html!(@post.body, %Earmark.Options{code_class_prefix: "language-"})) %>
    """
  end
end
