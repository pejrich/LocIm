defmodule LocIm.Api.LocationController do
  use LocIm.Web, :controller

  def index(conn, params) do
    render conn, "index.json"
  end
end