defmodule Keypress.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :string
      add :url, :string
      add :number, :integer
      add :published_at, :utc_datetime
      add :updated_at, :utc_datetime
    end

    create index(:posts, :number)
  end
end
