defmodule LocIm.Api.LocationView do
  use LocIm.Web, :view

  def render("index.json", %{posts: posts}) do
    %{
        posts: Phoenix.View.render_many(posts, LocIm.Api.PostView, "show.json")
    }
  end
end