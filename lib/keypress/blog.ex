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

  def post_body_as_text(post) do
    post.body
    |> Earmark.as_ast!()
    |> ast_to_string()
  end

  defp ast_to_string(node, acc \\ "")

  defp ast_to_string([{_, _, children, _} | rest], acc) do
    ast_to_string(rest, ast_to_string(children, acc))
  end

  defp ast_to_string([string | rest], acc) when is_binary(string) do
    ast_to_string(rest, acc <> " " <> string)
  end

  defp ast_to_string([], acc), do: String.trim(acc)
end
