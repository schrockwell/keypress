defmodule Keypress.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :string
      add :url, :string
      add :type, :string, null: false
      add :published_at, :utc_datetime
      add :edited_at, :utc_datetime
      timestamps()
    end
  end
end
