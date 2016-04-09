defmodule LocIm.Api.PostController do
  use LocIm.Web, :controller
  alias LocIm.Post

  def show(conn, %{"id" => post_id}) do
    
    case post = Post |> Repo.get(post_id) do
      nil -> 
        put_status(conn, 404)
        |> json %{message: "No post with id: #{post_id}"}
      _ -> 
        post = Repo.preload(post, :user)
        conn = conn
        |> assign(:post, post)
        |> render "show.json"
    end    
  end

  def create(conn, %{"post" => post_params}) do
    case post_params do
      %{
      "category"    => category,
      "status"      => status,
      "image"       => %Plug.Upload{content_type: cont_type, filename: filename, path: filepath},
      "latitude"    => latitude,
      "longitude"   => longitude,
      "reaction"    => reaction,
      "auth_token"  => auth_token
      } ->
        loc = %Geo.Point{coordinates: {longitude, latitude}}
        image_path = PostUploadServer.upload(filepath, filename)
        params = %{user_id: auth_token, reaction: reaction, category: category,
                    location: loc, image: image_path, status: status}
        changeset = Post.changeset(%Post{}, params)
        case LocIm.Repo.insert(changeset) do
          {:ok, post} -> 
            redirect conn, to: post_path(LocIm.Endpoint, :show, post.id)
        end
      _ -> json conn, %{message: "missing stuff"}
    end
  end
end



# %{"category" => category,
#        "image" => %Plug.Upload{content_type: cont_type, filename: filename, path: filepath},
#        "latitude" => latitude,
#        "longitude" => longitude,
#        "reaction" => reaction,
#        "auth_token" => auth_token}


#        %{"category" => "food",
#   "image" => %Plug.Upload{content_type: "image/jpeg",
#    filename: "geolocation_sketch.jpg",
#    path: "/var/folders/dd/5n839rmj22985qc_8g97sj840000gn/T//plug-1460/multipart-232426-998079-2"},
#   "latitude" => "10.786377", "longitude" => "106.700292", "reaction" => "true"} 