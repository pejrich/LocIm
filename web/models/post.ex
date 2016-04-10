defmodule LocIm.Post do
  use LocIm.Web, :model
  import Ecto.Query
  alias LocIm.{Repo, Post}
  import Geo.PostGIS

  schema "posts" do
    field :status, :string
    belongs_to :user, LocIm.User
    field :location, Geo.Point
    field :image, :string
    field :category, :string
    field :reaction, :boolean
    field :original_filename, :string

    timestamps
  end

  @required_fields ~w(status location image category reaction user_id)
  @optional_fields ~w(original_filename)
  @category_options ["food", "sight", "accommodation", "place of interest"]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:image)
    |> validate_not_empty(:status)
    |> validate_inclusion(:category, @category_options, message: "is incorrect, please use " <> Enum.join(@category_options, "/"))
    |> foreign_key_constraint(:user_id)
  end

  def within(longitude, latitude, radius) do
    point2 = %Geo.Point{coordinates: {longitude, latitude}}
    query = from post in Post, where: st_distance(post.location, ^point2)  < ^radius,  select: post
  end

  def longitude(post) do
    elem(post.location.coordinates, 0)
  end

  def latitude(post) do
    elem(post.location.coordinates, 1)
  end

  def format_post_params(%{auth_token: auth_token, latitude: latitude, longitude: longitude,
        image: %Plug.Upload{content_type: cont_type, filename: filename, path: filepath}} = params) do
    location = %Geo.Point{coordinates: {longitude, latitude}}
    image_path = LocIm.PostUploadServer.upload(filepath, filename)
    user_id = LocIm.User.auth_token_to_user_id(auth_token)
    params = params
    |> Map.delete(:longitude)
    |> Map.delete(:latitude)
    |> Map.put(:user_id, user_id)
    |> Map.put(:image, image_path)
    |> Map.put(:location, location)
    |> Map.put(:original_filename, filename)
  end

  defp validate_not_empty(changeset, key) do
    val = get_field(changeset, key)
    changeset = case val do
      "" -> 
        add_error(changeset, key, "#{key} cannot be empty")
      nil -> 
        add_error(changeset, key, "#{key} cannot be empty")
      _ -> changeset
    end
    changeset
  end
end
