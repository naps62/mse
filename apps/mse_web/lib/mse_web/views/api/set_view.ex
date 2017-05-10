defmodule Mse.Web.API.SetView do
  use Mse.Web, :view

  def render("index.json", %{sets: sets}) do
    sets
  end
end
