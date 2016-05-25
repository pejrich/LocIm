defmodule LocIm.User do
  use LocIm.Web, :model
  alias LocIm.User
  import Ecto.Query

  schema "users" do
    field :username, :string
    field :full_name, :string
    field :avatar, :string
    field :cover, :string
    field :location, Geo.Point
    field :auth_token, :string
    field :fb_id, :string

    timestamps
  end

  @required_fields ~w(username full_name)
  @optional_fields ~w(avatar cover auth_token fb_id)
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

  def changeset_register(model, params \\ :empty) do
    changeset(model, params)
    |> gen_auth_token_changeset
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

  # Auth Token Methods

  def gen_auth_token(user) do
    changeset = User.changeset(user, %{auth_token: new_token})
    LocIm.Repo.update(changeset)
  end

  def gen_auth_token_changeset(changeset) do
    put_change(changeset, :auth_token, new_token)
  end

  def new_token do
    :crypto.hash(:sha256, :erlang.timestamp |> elem(2) |> Integer.to_string)
    |> Base.encode16
  end

  def gen_username(string, extra \\ "") do
    temp_username = string <> extra
    query = from u in User, where: u.username == ^"#{temp_username}"
    case (LocIm.Repo.all(query) |> Enum.count) do
      0 -> string
      _ -> gen_username(string, "_#{:rand.uniform(300)}")
    end
  end

  def auth_token_to_user_id(auth_token) do
    case user = LocIm.Repo.get_by(LocIm.User, auth_token: auth_token) do
      nil -> nil
      user -> user.id
    end
  end
end
