defmodule Softie.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :content, :text

      timestamps()
    end

  end
end
