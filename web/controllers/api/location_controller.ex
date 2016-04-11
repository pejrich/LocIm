defmodule LocIm.Api.LocationController do
  use LocIm.Web, :controller

  @default_radius 500

  def index(conn, %{"latitude" => latitude, "longitude" => longitude} = params) do
    latitude = String.to_float("#{latitude}")
    longitude = String.to_float("#{longitude}")
    radius = String.to_integer("#{Map.get(params, "radius") || @default_radius}")
    query = LocIm.Post.within(longitude, latitude, radius)
    case params do
      %{"category" => category} ->
        query = from p in query, where: p.category == ^category
      _ -> :nil
    end
    posts = LocIm.Repo.all(query)
    conn
    |> assign(:posts, posts)
    |> render "index.json"
  end

  def index(conn, _) do
    put_status(conn, 422)
    |> json(%{message: "Please provide a valid longitude and latitude"})
  end
end