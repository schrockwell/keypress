defmodule Keypress.Repo.Migrations.FixTextFields do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :title, :text
      modify :body, :text
      modify :url, :text
    end
  end
end
