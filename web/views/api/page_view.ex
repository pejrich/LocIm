defmodule LocIm.Api.PageView do
  use LocIm.Web, :view

  def render("index.json", %{user: user}) do
    %{
      user: user
    }
  end

end
