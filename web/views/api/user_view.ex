defmodule LocIm.Api.UserView do
  use LocIm.Web, :view

  def render("user.json", %{user: user}) do
    %{
      here: "from user view",
      name: "Peter",
      id: 1,
      profile_picture_url: "https://www.drupal.org/files/profile_default.png"
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