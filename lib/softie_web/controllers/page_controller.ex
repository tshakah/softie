defmodule SoftieWeb.PageController do
  use SoftieWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
