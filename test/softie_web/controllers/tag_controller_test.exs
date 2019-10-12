defmodule SoftieWeb.TagControllerTest do
  use SoftieWeb.ConnCase

  alias Softie.Articles

  @tag_attrs %{name: "HOPE", scope: "Systems"}

  setup %{conn: conn} = _config do
    {:ok, tag} = Articles.create_tag(@tag_attrs)

    {:ok, %{conn: conn, tag: tag}}
  end

  test "lists all tags", %{conn: conn, tag: tag} do
    conn = get conn, Routes.tag_path(conn, :index)
    assert html_response(conn, 200) =~ "Tags"
    assert html_response(conn, 200) =~ "#{tag.scope}::#{tag.name}"
  end

  test "renders new tag form", %{conn: conn} do
    conn = get conn, Routes.tag_path(conn, :new)
    assert html_response(conn, 200) =~ "New tag"
  end

  @tag skip: :setup
  test "redirects to show when data is valid", %{conn: conn} do
    conn = post conn, Routes.tag_path(conn, :create), tag: %{@tag_attrs | scope: "NOSCOPE"}

    assert redirected_to(conn) == Routes.tag_path(conn, :index)

    conn = get conn, Routes.tag_path(conn, :index)
    assert html_response(conn, 200) =~ "#{@tag_attrs.scope}::#{@tag_attrs.name}"
  end

  test "renders errors when new data is invalid", %{conn: conn} do
    conn = post conn, Routes.tag_path(conn, :create), tag: %{@tag_attrs | name: nil}
    assert html_response(conn, 200) =~ "New tag"
    assert html_response(conn, 200) =~ "Name can&#39;t be blank"
  end

  test "renders form for editing chosen tag", %{conn: conn, tag: tag} do
    conn = get conn, Routes.tag_path(conn, :edit, tag)
    assert html_response(conn, 200) =~ "Edit tag"
  end

  test "redirects when edit data is valid", %{conn: conn, tag: tag} do
    conn = put conn, Routes.tag_path(conn, :update, tag), tag: %{@tag_attrs | name: "JOY"}
    assert redirected_to(conn) == Routes.tag_path(conn, :index)

    conn = get conn, Routes.tag_path(conn, :index)
    assert html_response(conn, 200) =~ "#{tag.scope}::JOY"
  end

  test "renders errors when edit data is invalid", %{conn: conn, tag: tag} do
    conn = put conn, Routes.tag_path(conn, :update, tag), tag: %{@tag_attrs | name: nil}
    assert html_response(conn, 200) =~ "Edit tag"
    assert html_response(conn, 200) =~ "Name can&#39;t be blank"
  end

  test "deletes chosen tag", %{conn: conn, tag: tag} do
    conn = delete conn, Routes.tag_path(conn, :delete, tag)
    assert redirected_to(conn) == Routes.tag_path(conn, :index)

    conn = get conn, Routes.tag_path(conn, :index)
    refute html_response(conn, 200) =~ "#{tag.scope}::#{tag.name}"
  end
end
