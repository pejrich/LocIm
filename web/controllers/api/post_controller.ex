defmodule LocIm.Api.PostController do
  use LocIm.Web, :controller

  def show(conn, %{"id" => post_id}) do
    post = LocIm.Repo.get(LocIm.Post, post_id)
    conn = conn
    |> assign(:post_id, post_id)
    |> assign(:post, post)
    case post do
      nil -> render conn, "nopost.json"
      _ -> render conn, "show.json"
    end    
  end

  def create(conn, _params) do
    render conn, "create.json"
  end
end