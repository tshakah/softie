defmodule SoftieWeb.TagController do
  use SoftieWeb, :controller

  alias Softie.Articles
  alias Softie.Articles.Tag

  def index(conn, _params) do
    tags = Articles.list_tags()
    render(conn, "index.html", tags: tags)
  end

  def new(conn, _params) do
    changeset = Articles.change_tag(%Tag{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Articles.create_tag(tag_params) do
      {:ok, _tag} ->
        conn
        |> put_flash(:info, "Tag created successfully.")
        |> redirect(to: Routes.tag_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    tag = Articles.get_tag!(id)
    changeset = Articles.change_tag(tag)

    render(conn, "edit.html", tag: tag, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Articles.get_tag!(id)

    case Articles.update_tag(tag, tag_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Tag updated successfully.")
        |> redirect(to: Routes.tag_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tag: tag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Articles.get_tag!(id)
    {:ok, _tag} = Articles.delete_tag(tag)

    conn
    |> put_flash(:info, "Tag deleted successfully.")
    |> redirect(to: Routes.tag_path(conn, :index))
  end
end
