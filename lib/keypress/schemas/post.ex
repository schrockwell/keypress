defmodule Keypress.Schemas.Post do
  use Keypress.Schema

  @types [:link, :short, :long]

  schema "posts" do
    field :title, :string
    field :body, :string
    field :url, :string
    field :type, Ecto.Enum, values: @types, default: :short
    field :published_at, :utc_datetime_usec
    field :edited_at, :utc_datetime_usec
    timestamps()

    # Virtual
    field :publish_now, :boolean, virtual: true, default: true
    field :flag_as_edited, :boolean, virtual: true, default: false
  end
end
