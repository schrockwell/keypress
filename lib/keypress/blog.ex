defmodule Keypress.Blog do
  import Ecto.Query

  alias Keypress.Repo
  alias Keypress.Schemas.Post

  def get_published_post!(id) do
    Post
    |> where([p], not is_nil(p.published_at))
    |> where([p], p.id == ^id)
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
end
