defmodule KeypressWeb.Admin.PostLive.Index do
  use KeypressWeb, :live_view

  alias Keypress.BlogAdmin

  def mount(_, _, socket) do
    {:ok, assign(socket, drafts: BlogAdmin.list_all_drafts())}
  end
end
