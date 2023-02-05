defmodule KeypressWeb.OnMount do
  def on_mount(:public, _params, %{"theme" => theme} = _session, socket) do
    {:cont, Phoenix.Component.assign(socket, theme: theme)}
  end

  def on_mount(:admin, _params, %{"authenticated" => true} = _session, socket) do
    {:cont, Phoenix.Component.assign(socket, theme: "tailwind")}
  end
end
