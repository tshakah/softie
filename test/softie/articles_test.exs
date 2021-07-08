defmodule Softie.ArticlesTest do
  use Softie.DataCase

  alias Softie.Articles

  @article_attrs %{content: "some content"}
  @tag_attrs %{name: "some name", scope: "some scope"}

  describe "articles" do
    alias Softie.Articles.Article

    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Articles.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Articles.create_article(@article_attrs)
      assert article.content == "some content"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Articles.update_article(article, @update_attrs)
      assert article.content == "some updated content"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert article == Articles.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end
  end

  describe "tags" do
    alias Softie.Articles.Tag

    @update_attrs %{name: "some updated name", scope: "some updated scope"}
    @invalid_attrs %{name: nil, scope: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Articles.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Articles.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Articles.create_tag(@tag_attrs)
      assert tag.name == "some name"
      assert tag.scope == "some scope"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_tag(@invalid_attrs)
    end

    test "create_tag/1 with duplicate name returns error changeset" do
      _tag = tag_fixture()

      assert {:error, %Ecto.Changeset{}} = Articles.create_tag(@tag_attrs)
    end

    test "create_tag/1 with duplicate name in different scope creates a tag" do
      _tag = tag_fixture()

      assert {:ok, %Tag{}} = Articles.create_tag(%{@tag_attrs | scope: "NOSCOPE"})
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Articles.update_tag(tag, @update_attrs)
      assert tag.name == "some updated name"
      assert tag.scope == "some updated scope"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_tag(tag, @invalid_attrs)
      assert tag == Articles.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Articles.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Articles.change_tag(tag)
    end
  end

  describe "article_tags" do
    alias Softie.Articles.ArticleTag

    @invalid_attrs %{article_id: nil, tag_id: nil}

    def article_tag_fixture(attrs \\ %{}) do
      article = article_fixture()
      tag = tag_fixture()

      {:ok, article_tag} =
        attrs
        |> Enum.into(%{article_id: article.id, tag_id: tag.id})
        |> Articles.create_article_tag()

      article_tag
    end

    test "list_article_tags/0 returns all article_tags" do
      article_tag = article_tag_fixture()
      assert Articles.list_article_tags() == [article_tag]
    end

    test "get_article_tag!/1 returns the article_tag with given id" do
      article_tag = article_tag_fixture()
      assert Articles.get_article_tag!(article_tag.id) == article_tag
    end

    test "create_article_tag/1 with valid data creates a article_tag" do
      article = article_fixture()
      tag = tag_fixture()

      assert {:ok, %ArticleTag{} = article_tag} = Articles.create_article_tag(%{article_id: article.id, tag_id: tag.id})
    end

    test "create_article_tag/1 doesn't accept duplicates" do
      article = article_fixture()
      tag = tag_fixture()

      assert {:ok, %ArticleTag{} = article_tag} = Articles.create_article_tag(%{article_id: article.id, tag_id: tag.id})
      assert {:error, %Ecto.Changeset{}} = Articles.create_article_tag(%{article_id: article.id, tag_id: tag.id})
    end

    test "create_article_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article_tag(@invalid_attrs)
    end

    test "delete_article_tag/1 deletes the article_tag" do
      article_tag = article_tag_fixture()
      assert {:ok, %ArticleTag{}} = Articles.delete_article_tag(article_tag)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article_tag!(article_tag.id) end
    end
  end

  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(@article_attrs)
      |> Articles.create_article()

    article
  end

  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(@tag_attrs)
      |> Articles.create_tag()

    tag
  end
end
