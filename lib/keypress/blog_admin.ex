defmodule Keypress.BlogAdmin do
  import Ecto.Changeset
  import Ecto.Query

  alias Keypress.Repo
  alias Keypress.Schemas.Post

  def get_post_by_id!(id) do
    Repo.get!(Post, id)
  end

  def list_all_posts(opts \\ []) do
    limit = opts[:limit]

    Post
    |> limit(^limit)
    |> order_by([p], desc: p.number)
    |> Repo.all()
  end

  def list_all_drafts do
    Post
    |> where([p], is_nil(p.published_at))
    |> order_by([p], p.title)
    |> Repo.all()
  end

  def change_post(%Post{} = post, params \\ %{}) do
    post
    |> cast(params, [:title, :body, :url, :type])
    |> validate_required([:type])
    |> validate_type_required()
  end

  defp validate_type_required(changeset) do
    case get_field(changeset, :type) do
      :short -> validate_required(changeset, [:body])
      :long -> validate_required(changeset, [:body, :title])
      :link -> validate_required(changeset, [:url, :title])
      _else -> changeset
    end
  end

  def save_post(%Post{} = post, params \\ %{}, opts \\ []) do
    post
    |> change_post(params)
    |> Repo.insert_or_update()
    |> case do
      {:ok, post} ->
        if opts[:publish] do
          {:ok, publish_post!(post)}
        else
          {:ok, post}
        end

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def publish_post!(%Post{number: nil, published_at: nil} = post) do
    post
    |> change(number: get_next_number(), published_at: DateTime.utc_now())
    |> Repo.update!()
  end

  def publish_post!(%Post{} = post) do
    post
    |> change(edited_at: DateTime.utc_now())
    |> Repo.update!()
  end

  defp get_next_number do
    Post
    |> select([p], max(p.number))
    |> Repo.one()
    |> case do
      nil -> 1
      number -> number + 1
    end
  end

  def delete_post(post) do
    Repo.delete(post)
  end
end
