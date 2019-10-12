defmodule SoftieWeb.Router do
  use SoftieWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SoftieWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/tags", TagController, except: [:show]
    resources "/articles", ArticleController

    live "/articles/:id", ArticleLive
  end
end
