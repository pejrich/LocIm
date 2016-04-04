defmodule LocIm.Api.UserController do
  use LocIm.Web, :controller

  def show(conn, _params) do
    render conn, "user.json"
  end

  def follow(conn, %{"user_id" => user_id}) do
    conn = assign(conn, :user_id, user_id)
    render conn, "follow.json"
  end

  def unfollow(conn, %{"user_id" => user_id}) do
    conn = assign(conn, :user_id, user_id)
    render conn, "unfollow.json"
  end

end