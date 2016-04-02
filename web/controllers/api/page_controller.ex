defmodule LocIm.Api.PageController do
  use LocIm.Web, :controller

  def index(conn, _params) do
    conn = conn
    |> assign :user, "jim"
    render(conn, "index.json")
  end
end
