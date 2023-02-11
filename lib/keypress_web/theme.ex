defmodule KeypressWeb.Theme do
  use KeypressWeb, :html

  alias Keypress.Schemas.Post

  @themes %{"tailwind" => KeypressWeb.TailwindTheme}

  @callback body_attrs :: %{atom => any}
  @callback app(assigns :: map) :: Phoenix.LiveView.Rendered.t()
  @callback post_preview(assigns :: map) :: Phoenix.LiveView.Rendered.t()
  @callback post_body(assigns :: map) :: Phoenix.LiveView.Rendered.t()

  attr :flash, :map, required: true
  attr :theme, :string, required: true
  attr :header?, :boolean, default: true
  slot :inner_block, required: true

  def app(%{theme: theme} = assigns) do
    @themes[theme].app(assigns)
  end

  attr :theme, :string, required: true
  attr :post, Post, required: true
  attr :class, :any, default: nil
  attr :editable, :boolean, default: false

  def post_preview(%{theme: theme} = assigns) do
    @themes[theme].post_preview(assigns)
  end

  attr :theme, :string, required: true
  attr :post, Post, required: true

  def post_body(%{theme: theme} = assigns) do
    @themes[theme].post_body(assigns)
  end

  def body_attrs(theme) do
    @themes[theme].body_attrs()
  end
end
