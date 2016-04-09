defmodule LocIm.User do
  use LocIm.Web, :model

  schema "users" do
    field :username, :string
    field :full_name, :string
    field :avatar, :string
    field :cover, :string
    field :location, Geo.Point

    timestamps
  end

  @required_fields ~w(username full_name)
  @optional_fields ~w(avatar cover)
  @default_avatar_url "https://www.sparklabs.com/forum/styles/comboot/theme/images/default_avatar.jpg"
  @default_cover_urls ["https://unsplash.com/photos/W2KEyYAAvU4", "https://unsplash.com/photos/SK3uHKx5nCU",
                      "https://unsplash.com/photos/4LYbjO_hDDw", "https://unsplash.com/photos/9j1hXX8jO1I"]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:username)
    |> validate_length(:username, min: 4)
    |> validate_length(:full_name, min: 4)
  end

  def avatar_url(user) do
    case user.avatar do
      nil -> @default_avatar_url
      "" -> @default_avatar_url
      _ -> user.avatar
    end
  end

  def cover_url(user) do
    case user.cover do
      nil -> Enum.random(@default_cover_urls)
      "" -> Enum.random(@default_cover_urls)
      _ -> user.cover
    end
  end
end
