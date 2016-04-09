defmodule LocIm.Api.PostController do
  use LocIm.Web, :controller
  alias LocIm.Post

  def show(conn, %{"id" => post_id}) do
    case post = Post |> Repo.get(post_id) do
      nil -> 
        put_status(conn, 404)
        |> json(%{message: "No post with id: #{post_id}"})
      _ -> 
        post = Repo.preload(post, :user)
        conn = conn
        |> assign(:post, post)
        |> render("show.json")
    end    
  end

  def create(conn, %{"post" => post_params}) do
    IO.puts "\n\n\n #{inspect post_params} \n\n\n"
    post = Post.from_post_params(post_params)
    case Repo.insert(post) do
      {:ok, post} -> redirect conn, to: post_path(LocIm.Endpoint, :show, post.id)
      {:error, %{errors: errors}} ->
        errors_map = Enum.reduce(errors, %{}, fn({key, val}, acc) -> Map.put(acc, key, val) end)
        json conn, %{status: "Some parameters are missing or incorrect", errors: errors_map}
      _ -> json conn, %{status: "Some parameters are missing or incorrect"}
    end
  end
end
