defmodule KeypressWeb.TailwindTheme do
  use KeypressWeb, :html
  @behaviour KeypressWeb.Theme

  embed_templates "tailwind/*"

  def body_attrs do
    %{class: "bg-slate-100 antialiased"}
  end
end
