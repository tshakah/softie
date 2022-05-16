defmodule SoftieWeb.ArticleLive.Show do
  use Phoenix.LiveView
  alias Softie.Articles

  def render(assigns) do
    Phoenix.View.render(SoftieWeb.ArticleView, "show.html", assigns)
  end

  def handle_params(%{"id" => id}, _url, socket) do
    article = Articles.get_article!(id)

    if connected?(socket), do: Articles.subscribe(id)

    {:noreply, assign(socket, :article, article)}
  end

  def handle_info({Articles, [:article, :updated], article}, socket) do
    {:noreply, assign(socket, :article, article)}
  end
end
