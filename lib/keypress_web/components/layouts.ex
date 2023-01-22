defmodule KeypressWeb.Layouts do
  use KeypressWeb, :html

  embed_templates "layouts/*"

  attr :theme, :string, required: true

  # Delegate to the current theme instead of using layouts/app.html.heex
  def app(assigns) do
    KeypressWeb.Theme.app(assigns)
  end
end
