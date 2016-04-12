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

  pipeline :auth do
    plug LocIm.Auth, repo: LocIm.Repo
  end

  scope "/", LocIm do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
  end

  scope "/api", LocIm do
    pipe_through :api

    scope "/" do
      pipe_through :auth

      get "/location", Api.LocationController, :index
      get "/feed", Api.FeedController, :index
      resources "/posts", Api.PostController, only: [:show, :create]  
      resources "/users", Api.UserController, only: [:show] do
        post "/follow", Api.UserController, :follow
        post "/unfollow", Api.UserController, :unfollow
      end
    end  


  end

  # Other scopes may use custom stacks.
  # scope "/api", LocIm do
  #   pipe_through :api
  # end
end
