defmodule KeypressWeb.Admin.PostLive.Edit do
  use KeypressWeb, :live_view

  alias Keypress.BlogAdmin
  alias Keypress.Schemas.Post

  def handle_params(%{"type" => type}, _url, %{assigns: %{live_action: :new}} = socket) do
    {:noreply,
     assign(socket,
       post: %Post{},
       changeset: BlogAdmin.change_post(%Post{}, %{type: type})
     )}
  end

  def handle_params(%{"id" => id}, _url, %{assigns: %{live_action: :edit}} = socket) do
    post = BlogAdmin.get_post_by_id!(id)

    {:noreply,
     assign(socket,
       post: post,
       changeset: BlogAdmin.change_post(post)
     )}
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    case BlogAdmin.save_post(socket.assigns.post, post_params) do
      {:ok, published, post} when published in [:published, :updated] ->
        {:noreply, push_navigate(socket, to: ~p"/#{post.number}")}

      {:ok, :draft, _post} ->
        {:noreply, push_navigate(socket, to: ~p"/posts")}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def handle_event("delete", _params, socket) do
    BlogAdmin.delete_post(socket.assigns.post)
    {:noreply, push_navigate(socket, to: ~p"/posts")}
  end
end
