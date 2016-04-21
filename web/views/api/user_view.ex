defmodule LocIm.Api.UserView do
  use LocIm.Web, :view
  alias LocIm.User

  def render("user.json", %{user: user}) do
    %{
      full_name: user.full_name,
      username: user.username,
      id: user.id,
      profile_picture_url: User.avatar_url(user),
      cover_picture_url: User.cover_url(user)
    }
  end

  def render("show.json", %{user: user, posts: posts, pager: pager}) do
    json = Phoenix.View.render_one(user, LocIm.Api.UserView, "user.json")
    |> Dict.put(:posts, Phoenix.View.render_many(posts, LocIm.Api.PostView, "post.json"))
    |> Dict.put(:pagination, %{page_number: pager.page_number, total_pages: pager.total_pages})
  end

  def render("show.json", %{user: user, posts: posts}) do
    %{
      user: %{
        full_name: user.full_name,
        username: user.username,
        id: user.id,
        profile_picture_url: User.avatar_url(user),
        cover_picture_url: User.cover_url(user)
      },
      posts: Phoenix.View.render_many(posts, LocIm.Api.PostView, "show.json")
    }
  end

  def render("show_with_token.json", %{user: user}) do
    # This should only be rendered to the user because it includes the auth_token
    json = Phoenix.View.render_one(user, LocIm.Api.UserView, "user.json")
    |> Dict.put(:auth_token, user.auth_token)
  end

  def render("follow.json", %{user_id: user_id}) do
    %{
      success: true,
      message: "Now following user with id: #{user_id}"
    }
  end

  def render("unfollow.json", %{user_id: user_id}) do
    %{
      success: true,
      message: "Stopped following user with id: #{user_id}" 
    }
  end
end