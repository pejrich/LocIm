defmodule LocIm.Api.LocationController do
  use LocIm.Web, :controller

  @default_radius 500

  def index(conn, %{"latitude" => latitude, "longitude" => longitude} = params) do
    radius = String.to_integer("#{Map.get(params, "radius") || @default_radius}")
    case params do
      %{"categories" => categories} ->
        json(conn, %{mess: "with cat #{radius}"})
      _ ->   
        posts = LocIm.Post.within(longitude, latitude, radius)
        |> LocIm.Repo.all
        conn = assign(conn, :posts, posts)
        render conn, "index.json"
    end
  end

  def index(conn, _) do
    put_status(conn, 422)
    |> json(%{message: "Please provide a valid longitude and latitude"})
  end
end