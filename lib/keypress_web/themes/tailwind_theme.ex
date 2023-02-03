defmodule KeypressWeb.TailwindTheme do
  use KeypressWeb, :html

  embed_templates "tailwind/*"

  attr :rest, :global
  slot :inner_block, required: true

  def a(assigns) do
    ~H"""
    <.link class="text-purple-500 transition-colors duration-300 hover:text-purple-700" {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end
end
