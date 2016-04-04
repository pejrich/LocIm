defmodule LocIm.Api.PostController do
  use LocIm.Web, :controller

  def show(conn, _params) do
    render conn, "show.json"
  end

  def create(conn, _params) do
    render conn, "create.json"
  end
end