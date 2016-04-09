defmodule LocIm.Api.UserView do
  use LocIm.Web, :view
  alias LocIm.User

  def render("user.json", %{user: user}) do
    %{
      full_name: user.full_name,
      username: user.username,
      id: user.id,
      profile_picture_url: User.avatar_url(user),
      cover_picture_url: User.cover_url(user),
    }
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