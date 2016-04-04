defmodule LocIm.Router do
  use LocIm.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LocIm do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", LocIm do
    pipe_through :api
    resources "/posts", Api.PostController, only: [:show, :create]
    resources "/users", Api.UserController, only: [:show] do
      get "/follow", Api.UserController, :follow
      get "/unfollow", Api.UserController, :unfollow
    end

    get "/location", Api.LocationController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LocIm do
  #   pipe_through :api
  # end
end
