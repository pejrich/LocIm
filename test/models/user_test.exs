defmodule LocIm.UserTest do
  use LocIm.ModelCase

  alias LocIm.User

  @valid_attrs %{full_name: "some content", username: "some content"}
  @invalid_attrs %{full_name: "", username: ""}
  @optional_attrs %{avatar: "some content", cover: "some content"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "user must have present and unique username" do
    changeset = User.changeset(%User{}, %{username: "username", full_name: "full_name"})
    assert changeset.valid?
    {:ok, _} = LocIm.Repo.insert(changeset)
    changeset2 = User.changeset(%User{}, %{username: "username", full_name: "full_name"})
    refute changeset2.valid?
  end
end
