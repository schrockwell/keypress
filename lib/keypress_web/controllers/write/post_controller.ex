defmodule KeypressWeb.Write.PostController do
  use KeypressWeb, :controller

  alias Keypress.BlogAdmin
  alias Keypress.Schemas.Post

  plug :assign_post

  def index(conn, _params) do
    render(conn, :index, drafts: BlogAdmin.list_all_drafts(), changeset: BlogAdmin.change_post(conn.assigns.post))
  end

  def show(conn, _params) do
    render(conn, :index, drafts: BlogAdmin.list_all_drafts(), changeset: BlogAdmin.change_post(conn.assigns.post))
  end

  def create(conn, %{"action" => "save-draft", "post" => post_params}) do
    conn.assigns.post
    |> BlogAdmin.save_post(post_params)
    |> case do
      {:ok, _post} ->
        conn
        |> put_flash(:success, "Draft saved")
        |> redirect(to: ~p"/write")

      {:error, changeset} ->
        render(conn, :index, drafts: BlogAdmin.list_all_drafts(), changeset: changeset)
    end
  end

  def create(conn, %{"action" => "save-and-publish", "post" => post_params}) do
    conn.assigns.post
    |> BlogAdmin.save_post(post_params, publish: true)
    |> case do
      {:ok, _post} ->
        conn
        |> put_flash(:success, "Post published")
        |> redirect(to: ~p"/write")

      {:error, changeset} ->
        render(conn, :index, drafts: BlogAdmin.list_all_drafts(), changeset: changeset)
    end
  end

  defp assign_post(conn, _) do
    if id = conn.params["id"] do
      assign(conn, :post, BlogAdmin.get_post_by_id!(id))
    else
      assign(conn, :post, %Post{})
    end
  end
end
