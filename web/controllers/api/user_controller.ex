defmodule LocIm.Api.UserController do
  use LocIm.Web, :controller

  # def show(conn, %{"id" => user_id, "page_number" => page_number}) do

  # end

  def show(conn, %{"id" => user_id} = params) do
    page_number = Map.get(params, "page_number", "1") |> String.to_integer
    user = LocIm.Repo.get(LocIm.User, user_id)
    pager = LocIm.Post.feed_for(user)
    |> Pager.paginate(page_number)
    conn = conn
    |> assign(:posts, pager.results)
    |> assign(:user, user)
    |> assign(:pager, pager)
    render conn, "show.json"
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