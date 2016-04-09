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

    timestamps
  end

  @required_fields ~w(status location image category reaction user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def within(latitude, longitude, radius) do
    point2 = %Geo.Point{coordinates: {longitude, latitude}}
    query = from post in Post, where: st_distance(post.location, ^point2)  < ^radius,  select: post
    Repo.all(query)
  end

  def longitude(post) do
    elem(post.location.coordinates, 0)
  end

  def latitude(post) do
    elem(post.location.coordinates, 1)
  end
end
