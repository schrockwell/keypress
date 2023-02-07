defmodule KeypressWeb.TailwindTheme do
  use KeypressWeb, :html

  alias Keypress.Schemas.Post

  embed_templates "tailwind/*"

  attr :class, :any, default: nil
  def post_preview(assigns)

  attr :post, Post, required: true

  def post_body(assigns) do
    ~H"""
    <%= raw(Earmark.as_html!(@post.body, %Earmark.Options{code_class_prefix: "language-"})) %>
    """
  end
end
