defmodule Keypress.BlogAdmin do
  import Ecto.Changeset
  import Ecto.Query

  alias Keypress.Repo
  alias Keypress.Schemas.Post

  def get_post_by_id!(id) do
    Post
    |> Repo.get!(id)
    |> case do
      %Post{published_at: nil} = post -> %{post | publish_now: false}
      post -> %{post | publish_now: true}
    end
  end

  def list_all_posts(opts \\ []) do
    limit = opts[:limit]

    Post
    |> limit(^limit)
    |> order_by([p], desc: p.id)
    |> Repo.all()
  end

  def list_all_drafts do
    Post
    |> where([p], is_nil(p.published_at))
    |> order_by([p], p.title)
    |> Repo.all()
  end

  def change_post(%Post{} = post, params \\ %{}, action \\ nil) do
    post
    |> cast(params, [:title, :body, :url, :type, :publish_now, :flag_as_edited])
    |> validate_required([:type])
    |> validate_type_required()
    |> Map.put(:action, action)
  end

  defp validate_type_required(changeset) do
    case get_field(changeset, :type) do
      :short -> validate_required(changeset, [:body])
      :long -> validate_required(changeset, [:body, :title])
      :link -> validate_required(changeset, [:url, :title])
      _else -> changeset
    end
  end

  def save_post(%Post{} = post, params \\ %{}) do
    post
    |> change_post(params)
    |> Repo.insert_or_update()
    |> case do
      {:ok, post} ->
        publish_post!(post)

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  # Publish and unpublished post: publish it
  def publish_post!(%Post{publish_now: true, published_at: nil} = post) do
    {:ok, :published,
     post
     |> change(published_at: DateTime.utc_now())
     |> Repo.update!()}
  end

  # Publishing an already-published post: only change edited_at
  def publish_post!(%Post{published_at: %DateTime{}, flag_as_edited: true} = post) do
    {:ok, :updated,
     post
     |> change(edited_at: DateTime.utc_now())
     |> Repo.update!()}
  end

  def publish_post!(%Post{published_at: %DateTime{}, flag_as_edited: false} = post) do
    {:ok, :updated, post}
  end

  # Draft post: do nothing
  def publish_post!(post), do: {:ok, :draft, post}

  def delete_post(post) do
    Repo.delete(post)
  end
end
