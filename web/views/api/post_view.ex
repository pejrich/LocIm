defmodule LocIm.Api.PostView do
  use LocIm.Web, :view

  def render("show.json", %{post: post}) do
    json = Phoenix.View.render_one(post, LocIm.Api.PostView, "post.json")
    Dict.put(json, :user, Phoenix.View.render_one(post.user, LocIm.Api.UserView, "user.json"))
  end

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      image_url: post.image,
      longitude: LocIm.Post.longitude(post),
      latitude: LocIm.Post.latitude(post),
      created_at: LocIm.UnixTimestamp.datetime_to_timestamp(post.inserted_at),
      category: post.category,
      reaction: post.reaction,
      status: post.status
    }
  end
end