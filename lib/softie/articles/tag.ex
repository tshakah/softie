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
    |> validate_required([:name])
    |> unique_constraint(:name, name: :unique_scoped_name)
  end
end
