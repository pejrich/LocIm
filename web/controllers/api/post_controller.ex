defmodule LocIm.Api.PostController do
  use LocIm.Web, :controller
  alias LocIm.Post

  @required_post_params [:longitude, :latitude,
                         :status, :reaction, :image, :category]

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

  def create(conn, %{"post" => post_params} = params) do
    IO.puts "\n\n\n in create \n\n\n"
    IO.puts "\n\n\n #{inspect conn} \n\n\n"
    IO.puts "\n\n\n #{inspect params} \n\n\n"
    post_params = post_params
    |> LocIm.Params.atomize
    |> LocIm.Params.remove_empty
    case @required_post_params -- Map.keys(post_params) do
      [] ->
        user = conn.assigns.current_user
        post_params = Map.put(post_params, :user_id, user.id)
        IO.puts "\n\npost_params\n #{inspect post_params} \n\n\n"
        post_params = Post.format_post_params(post_params)
        changeset = Post.changeset(%Post{}, post_params)
        case Repo.insert(changeset) do
          {:ok, post} -> 
            IO.puts "\n\nRedirecting to show\n #{inspect post} \n\n\n"
            post = LocIm.Repo.preload(post, :user)
            conn
            |> assign(:post, post)
            |> render("show.json")
          {:error, %{errors: errors}} ->
            errors_map = Enum.reduce(errors, %{}, fn({key, val}, acc) -> Map.put(acc, key, val) end)
            put_status(conn, 422)
            |> json(%{status: "Some parameters are missing or incorrect", errors: errors_map})
        end
        IO.puts "\n\n\n SHOULD NOT PRINT \n\n\n"
        conn
      missing_params ->
        put_status(conn, 422)
        |> json(%{missing_params: missing_params})
    end
  end
end
