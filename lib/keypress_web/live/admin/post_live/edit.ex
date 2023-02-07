defmodule KeypressWeb.Admin.PostLive.Edit do
  use KeypressWeb, :live_view

  alias Keypress.BlogAdmin
  alias Keypress.Schemas.Post

  def handle_params(%{"type" => type}, _url, %{assigns: %{live_action: :new}} = socket) do
    {:noreply,
     assign(socket,
       post: %Post{},
       changeset: BlogAdmin.change_post(%Post{}, %{type: type}),
       mode: :edit,
       post_preview: %Post{}
     )}
  end

  def handle_params(%{"id" => id}, _url, %{assigns: %{live_action: :edit}} = socket) do
    post = BlogAdmin.get_post_by_id!(id)

    {:noreply,
     assign(socket,
       post: post,
       changeset: BlogAdmin.change_post(post),
       mode: :edit,
       post_preview: %Post{}
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

  def handle_event("validate", %{"post" => post_params}, socket) do
    {:noreply, assign(socket, :changeset, BlogAdmin.change_post(socket.assigns.post, post_params, :change))}
  end

  def handle_event("change-mode", %{"mode" => mode}, socket) when mode in ["edit", "preview"] do
    {:noreply, assign_mode(socket, String.to_atom(mode))}
  end

  def handle_event("toggle-mode", _, socket) do
    next_mode = if socket.assigns.mode == :edit, do: :preview, else: :edit
    {:noreply, assign_mode(socket, next_mode)}
  end

  defp assign_mode(socket, :edit) do
    assign(socket, mode: :edit)
  end

  defp assign_mode(socket, :preview) do
    post_preview = Ecto.Changeset.apply_changes(socket.assigns.changeset)

    assign(socket, mode: :preview, post_preview: post_preview)
  end

  defp visible_if(true), do: nil
  defp visible_if(false), do: "hidden"

  attr :current_mode, :atom, values: [:edit, :preview], required: true
  attr :mode, :atom, values: [:edit, :preview], required: true
  attr :label, :string, required: true

  defp mode_button(assigns) do
    assigns =
      assign(
        assigns,
        :selected_class,
        if(assigns.mode == assigns.current_mode, do: "bg-black border-black text-white", else: "bg-white text-inherit")
      )

    ~H"""
    <button
      class={["border rounded-md px-4 py-2 font-medium text-sm", @selected_class]}
      phx-click="change-mode"
      phx-value-mode={@mode}
    >
      <%= @label %>
    </button>
    """
  end
end
