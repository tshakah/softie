defmodule SoftieWeb.ArticleControllerTest do
  use SoftieWeb.ConnCase

  alias Softie.Articles

  @article_attrs %{content: "Testing with some content"}

  setup %{conn: conn} = _config do
    {:ok, article} = Articles.create_article(@article_attrs)

    {:ok, %{conn: conn, article: article}}
  end

  test "lists all articles", %{conn: conn, article: article} do
    conn = get conn, Routes.article_path(conn, :index)
    assert html_response(conn, 200) =~ "Articles"
    assert html_response(conn, 200) =~ Routes.article_path(conn, :show, article.id)
  end

  test "renders new article form", %{conn: conn} do
    conn = get conn, Routes.article_path(conn, :new)
    assert html_response(conn, 200) =~ "New article"
  end

  @tag skip: :setup
  test "redirects to show when data is valid", %{conn: conn} do
    conn = post conn, Routes.article_path(conn, :create), article: @article_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.article_path(conn, :show, id)

    conn = get conn, Routes.article_path(conn, :show, id)
    assert html_response(conn, 200) =~ @article_attrs.content
  end

  test "renders errors when new data is invalid", %{conn: conn} do
    conn = post conn, Routes.article_path(conn, :create), article: %{@article_attrs | content: nil}
    assert html_response(conn, 200) =~ "New article"
    assert html_response(conn, 200) =~ "Content can&#39;t be blank"
  end

  test "renders form for editing chosen article", %{conn: conn, article: article} do
    conn = get conn, Routes.article_path(conn, :edit, article)
    assert html_response(conn, 200) =~ "Edit article"
  end

  test "redirects when edit data is valid", %{conn: conn, article: article} do
    conn = put conn, Routes.article_path(conn, :update, article), article: %{@article_attrs | content: "MOAR CONTENT"}

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.article_path(conn, :show, id)

    conn = get conn, Routes.article_path(conn, :show, id)
    assert html_response(conn, 200) =~ "MOAR CONTENT"
  end

  test "renders errors when edit data is invalid", %{conn: conn, article: article} do
    conn = put conn, Routes.article_path(conn, :update, article), article: %{@article_attrs | content: nil}
    assert html_response(conn, 200) =~ "Edit article"
    assert html_response(conn, 200) =~ "Content can&#39;t be blank"
  end

  test "deletes chosen article", %{conn: conn, article: article} do
    conn = delete conn, Routes.article_path(conn, :delete, article)
    assert redirected_to(conn) == Routes.article_path(conn, :index)

    conn = get conn, Routes.article_path(conn, :index)
    refute html_response(conn, 200) =~ Routes.article_path(conn, :show, article.id)
  end
end
