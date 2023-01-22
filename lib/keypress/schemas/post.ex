defmodule Keypress.Schemas.Post do
  use Ecto.Schema

  schema "posts" do
    field :number, :integer
    field :title, :string
    field :body, :string
    field :url, :string
    field :updated_at, :utc_datetime_usec
    field :published_at, :utc_datetime_usec
  end
end
