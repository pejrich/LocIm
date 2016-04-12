defmodule LocIm.Api.PostController do
  use LocIm.Web, :controller
  alias LocIm.Post

  @reqired_post_params [:longitude, :latitude, :status, :reaction,
                        :auth_token, :image, :category]

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
    post_params = post_params
    |> LocIm.Params.atomize
    |> LocIm.Params.remove_empty
    case @reqired_post_params -- Map.keys(post_params) do
      [] ->
        post_params = Post.format_post_params(post_params)
        changeset = Post.changeset(%Post{}, post_params)
        case Repo.insert(changeset) do
          {:ok, post} -> redirect conn, to: post_path(LocIm.Endpoint, :show, post.id)
          {:error, %{errors: errors}} ->
            errors_map = Enum.reduce(errors, %{}, fn({key, val}, acc) -> Map.put(acc, key, val) end)
            put_status(conn, 422)
            |> json(%{status: "Some parameters are missing or incorrect", errors: errors_map})
        end
        conn
      missing_params ->
        put_status(conn, 422)
        |> json(%{missing_params: missing_params})
    end
  end
end
