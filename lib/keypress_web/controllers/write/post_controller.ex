defmodule KeypressWeb.Write.PostController do
  use KeypressWeb, :controller

  alias Keypress.BlogAdmin
  alias Keypress.Schemas.Post

  plug :assign_post when action not in [:index]

  def index(conn, _params) do
    render(conn, :index, drafts: BlogAdmin.list_all_drafts())
  end

  def new(conn, %{"type" => type}) do
    render(conn, :new, changeset: BlogAdmin.change_post(conn.assigns.post, %{type: type}))
  end

  def new(conn, _) do
    render(conn, :new_type)
  end

  def edit(conn, _) do
    render(conn, :edit, changeset: BlogAdmin.change_post(conn.assigns.post))
  end

  def create(conn, %{"action" => "save-draft", "post" => post_params}) do
    conn.assigns.post
    |> BlogAdmin.save_post(post_params)
    |> case do
      {:ok, _post} ->
        conn
        |> put_flash(:success, "Draft saved")
        |> redirect(to: ~p"/posts")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def create(conn, %{"action" => "save-and-publish", "post" => post_params}) do
    conn.assigns.post
    |> BlogAdmin.save_post(post_params, publish: true)
    |> case do
      {:ok, post} ->
        conn
        |> put_flash(:success, "Post published")
        |> redirect(to: ~p"/#{post.number}")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def update(conn, %{"action" => "save-draft", "post" => post_params}) do
    conn.assigns.post
    |> BlogAdmin.save_post(post_params, publish: false)
    |> case do
      {:ok, _post} ->
        conn
        |> put_flash(:success, "Draft saved")
        |> redirect(to: ~p"/posts")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end

  def update(conn, %{"action" => "save-and-publish", "post" => post_params}) do
    conn.assigns.post
    |> BlogAdmin.save_post(post_params, publish: true)
    |> case do
      {:ok, post} ->
        conn
        |> put_flash(:success, "Post published")
        |> redirect(to: ~p"/#{post.number}")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end

  def update(conn, %{"action" => "delete"}) do
    BlogAdmin.delete_post(conn.assigns.post)
    redirect(conn, to: ~p"/posts")
  end

  defp assign_post(conn, _opts) do
    if id = conn.params["id"] do
      assign(conn, :post, BlogAdmin.get_post_by_id!(id))
    else
      assign(conn, :post, %Post{})
    end
  end
end
