defmodule Keypress.Schemas.Post do
  use Keypress.Schema

  schema "posts" do
    field :number, :integer
    field :title, :string
    field :body, :string
    field :url, :string
    field :type, Ecto.Enum, values: [:link, :short, :long], default: :short
    field :published_at, :utc_datetime_usec

    timestamps()
  end
end
