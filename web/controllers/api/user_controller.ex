defmodule LocIm.Api.UserController do
  use LocIm.Web, :controller
  alias LocIm.User

  def show(conn, %{"id" => user_id} = params) do
    page_number = Map.get(params, "page_number", "1") |> String.to_integer
    user = LocIm.Repo.get(User, user_id)
    pager = LocIm.Post.feed_for(user)
    |> Pager.paginate(page_number)
    conn = conn
    |> assign(:posts, pager.results)
    |> assign(:user, user)
    |> assign(:pager, pager)
    render conn, "show.json"
  end

  def create(conn, %{"fb_user_id" => fb_user_id, "fb_token" => fb_token}) do
    url = "https://graph.facebook.com/me?fields=id,first_name,name,last_name&access_token=" <> fb_token
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Poison.decode(body) do
          {:ok, body} -> 
            first_of_create_from_fb_data(conn, body)
          _ -> conn |> put_status(422) |> json(%{message: "Invalid JSON from Facebook"}) |> halt
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
        conn |> put_status(422) |> json(%{message: reason}) |> halt
    end
  end

  def first_of_create_from_fb_data(conn, %{"name" => name, "id" => fb_id}) do

    case LocIm.Repo.get_by(User, fb_id: fb_id) do
      nil -> 
        changeset = User.changeset_register(%User{}, %{full_name: name, username: User.gen_username(name), fb_id: fb_id})
        IO.puts "\n\nCHANGESET\n #{inspect changeset} \n\n\n"
        case LocIm.Repo.insert(changeset) do
          {:ok, user} ->
            conn
            |> assign(:user, user)
            |> render("show_with_token.json")
          {:error, reason} -> 
            conn |> put_status(422) |> json(%{message: reason}) |> halt
        end
      %User{auth_token: nil} = user ->
        {:ok, user} = User.gen_auth_token(user)
        conn
        |> assign(:user, user)
        |> render("show_with_token.json")
      %User{auth_token: auth_token} = user ->
        conn
        |> assign(:user, user)
        |> render("show_with_token.json")
    end
    
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