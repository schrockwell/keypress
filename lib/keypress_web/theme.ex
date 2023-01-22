defmodule KeypressWeb.Theme do
  @themes %{"tailwind" => KeypressWeb.TailwindTheme}
  @components [:app, :post_preview]

  defp theme_component(component, %{theme: theme} = assigns) do
    theme_module = Map.fetch!(@themes, theme)
    apply(theme_module, component, [assigns])
  end

  for component <- @components do
    def unquote(component)(assigns) do
      theme_component(unquote(component), assigns)
    end
  end
end
