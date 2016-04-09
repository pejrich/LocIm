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

  @required_fields ~w(username full_name avatar cover)
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
end
