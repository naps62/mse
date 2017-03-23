defmodule MseWeb.Web.API.SetView do
  use MseWeb.Web, :view

  def render("index.json", %{sets: sets}) do
    sets
  end
end
