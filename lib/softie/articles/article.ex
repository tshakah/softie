defmodule Softie.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset
  alias Softie.Articles.{ArticleTag, Tag}

  schema "articles" do
    field :content, :string

    many_to_many :tags, Tag, join_through: ArticleTag

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
