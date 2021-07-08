defmodule SoftieWeb.ArticleLive.Edit do
  use Phoenix.LiveView
  alias Softie.Articles

  def render(assigns) do
    Phoenix.View.render(SoftieWeb.ArticleView, "edit.html", assigns)
  end

  def handle_params(%{"id" => id}, _url, socket) do
    article = Articles.get_article!(id)

    if connected?(socket), do: Articles.subscribe(id)

    {:noreply, assign(socket, %{
       article: article,
       changeset: Articles.change_article(article)
    })}
  end

  def handle_event("update", %{"article" => attrs}, socket) do
    case Articles.update_article(socket.assigns.article, attrs) do
      {:ok, article} -> {:noreply, assign(socket, :article, article)}
      _ -> {:noreply, socket}
    end
  end

  def handle_info({Articles, [:article, :updated], article}, socket) do
    {:noreply, assign(socket, :article, article)}
  end
end
