defmodule Softie.Articles.ArticleTag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Softie.Articles.{Article, Tag}

  schema "article_tags" do
    belongs_to :article, Article
    belongs_to :tag, Tag

    timestamps()
  end

  @doc false
  def changeset(article_tag, attrs) do
    article_tag
    |> cast(attrs, [:article_id, :tag_id])
    |> validate_required([:article_id, :tag_id])
    |> foreign_key_constraint(:article_id)
    |> foreign_key_constraint(:tag_id)
    |> unique_constraint(:article_already_has_that_tag, name: :unique_article_tag)
  end
end
