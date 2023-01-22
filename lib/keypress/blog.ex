defmodule Keypress.Blog do
  import Ecto.Changeset
  import Ecto.Query

  alias Keypress.Repo
  alias Keypress.Schemas.Post

  def get_published_post_by_number!(number) do
    Post
    |> where([p], not is_nil(p.published_at))
    |> where([p], p.number == ^number)
    |> Repo.one!()
  end

  def list_published_posts(opts \\ []) do
    limit = opts[:limit]

    Post
    |> limit(^limit)
    |> where([p], not is_nil(p.published_at))
    |> order_by([p], desc: p.published_at)
    |> Repo.all()
  end

  def change_post(%Post{} = post, params \\ %{}) do
    post
    |> cast(params, [:title, :body, :url])
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
    |> change(updated_at: DateTime.utc_now())
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
end
