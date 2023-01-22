defmodule KeypressWeb.ThemePlug do
  @behaviour Plug

  import Plug.Conn

  @impl true
  def init(_), do: []

  @impl true
  def call(conn, _opts) do
    if theme = get_session(conn, "theme") do
      assign(conn, :theme, theme)
    else
      conn
      |> put_session("theme", "tailwind")
      |> assign(:theme, "tailwind")
    end
  end

  def put_theme(conn, theme) do
    put_session(conn, "theme", theme)
  end
end
