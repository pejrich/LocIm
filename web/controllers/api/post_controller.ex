defmodule LocIm.Api.PostController do
  use LocIm.Web, :controller

  def show(conn, %{"id" => post_id}) do
    case post = LocIm.Repo.get(LocIm.Post, post_id) do
      nil -> 
        put_status(conn, 404)
        |> json %{message: "No post with id: #{post_id}"}
      _ -> 
        conn = conn
        |> assign(:post, post)
        |> render "show.json"
    end    
  end

  def create(conn, _params) do
    render conn, "create.json"
  end
end