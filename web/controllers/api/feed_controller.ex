defmodule LocIm.Api.FeedController do
  use LocIm.Web, :controller
  import Ecto.Query

  @per_page 20

  def index(conn, %{"page_number" => page_number} ) do
    # Get Posts by page
    posts = String.to_integer("#{page_number}")
    |> feed_posts
    # Render Posts
    conn
    |> assign(:posts, posts)
    |> render("index.json")
  end

  # If no page number is included, set page_number to 1
  def index(conn, _) do
    index(conn, %{"page_number" => 1})
  end

  # Logic for what posts to show
  defp feed_posts(page_number) do
    skip = (page_number - 1) * @per_page
    query = from p in LocIm.Post, order_by: [desc: p.inserted_at], offset: ^skip, limit: @per_page, preload: :user
    posts = LocIm.Repo.all query
  end
end