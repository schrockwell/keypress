defmodule KeypressWeb.Layouts do
  use KeypressWeb, :html

  embed_templates "layouts/*"

  attr :theme, :string, required: true

  # Delegate to the current theme instead of using layouts/app.html.heex
  def app(assigns) do
    ~H"""
    <KeypressWeb.Theme.app theme={@theme} flash={@flash} header?={@header?}>
      <%= @inner_content %>
    </KeypressWeb.Theme.app>
    """
  end
end
