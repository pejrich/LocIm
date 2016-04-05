defmodule LocIm.Api.FeedController do
  use LocIm.Web, :controller

  def index(conn, _) do
    render conn, "index.json"
  end
end