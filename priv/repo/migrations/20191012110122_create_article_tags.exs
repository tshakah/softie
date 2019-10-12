defmodule Softie.Repo.Migrations.CreateArticleTags do
  use Ecto.Migration

  def change do
    create table(:article_tags) do
      add :article_id, references(:articles, on_delete: :delete_all)
      add :tag_id, references(:tags, on_delete: :delete_all)

      timestamps()
    end

    create index(:article_tags, [:article_id])
    create index(:article_tags, [:tag_id])
    create unique_index(:article_tags, [:article_id, :tag_id], name: :unique_article_tag)
  end
end
