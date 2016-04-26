defmodule LocIm.Api.FeedView do
  use LocIm.Web, :view

  def render("index.json", %{posts: posts}) do
    %{
        posts: Phoenix.View.render_many(posts, LocIm.Api.PostView, "show.json")
    }
  end
end