defmodule LocIm.PageController do
  use LocIm.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
