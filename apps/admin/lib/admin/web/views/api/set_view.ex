defmodule Admin.Web.API.SetView do
  use Admin.Web, :view

  def render("index.json", %{sets: sets}) do
    sets
  end
end
