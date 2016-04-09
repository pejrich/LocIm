defmodule LocIm.UserTest do
  use LocIm.ModelCase

  alias LocIm.User

  @valid_attrs %{avatar: "some content", cover: "some content", full_name: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
