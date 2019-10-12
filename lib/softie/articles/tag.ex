defmodule Softie.Articles.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Softie.Articles.{Article, ArticleTag}

  schema "tags" do
    field :name, :string
    field :scope, :string

    many_to_many :articles, Article, join_through: ArticleTag

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:scope, :name])
    |> validate_required([:scope, :name])
  end
end
