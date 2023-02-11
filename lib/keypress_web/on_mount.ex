defmodule KeypressWeb.OnMount do
  import Phoenix.Component

  def on_mount(:public, _params, %{"theme" => theme} = session, socket) do
    {:cont,
     assign(socket,
       theme: theme,
       authenticated?: Map.get(session, "authenticated", false),
       header?: true,
       og_meta: %{}
     )}
  end

  def on_mount(:admin, _params, %{"authenticated" => true} = _session, socket) do
    {:cont,
     assign(socket,
       theme: "tailwind",
       authenticated?: true,
       header?: false,
       og_meta: %{}
     )}
  end
end
