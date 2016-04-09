defmodule LocIm.Api.PostView do
  use LocIm.Web, :view

  def render("show.json", %{post: post}) do
    %{
      id: post.id,
      user: Phoenix.View.render_one(post.user, LocIm.Api.UserView, "user.json"),
      image_url: post.image,
      longitude: LocIm.Post.longitude(post),
      latitude: LocIm.Post.latitude(post),
      created_at: 1459762009,
      category: post.category,
      reaction: post.reaction,
      status: post.status
    }
  end

  def render("create.json", _) do
    %{
      success: true,
      message: "post has been created (not really...yet.)",
      post: %{
        id: 1,
        user: %{
          name: "Peter",
          id: 1,
          profile_picture_url: "https://www.drupal.org/files/profile_default.png"
        },
        image_url: "http://www.deluxegrouptours.vn/wp-content/uploads/2015/03/Notre-Dame-Cathedral-ho-chi-minh-city-tour-half-day4.jpg",
        longitude: 106.6989948,
        latitude: 10.7797838,
        created_at: 1459762009,
        category: "sight",
        reaction: true
      }
    }
  end
end