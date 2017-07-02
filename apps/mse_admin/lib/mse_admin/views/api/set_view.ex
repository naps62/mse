defmodule Mse.Admin.API.SetView do
  use Mse.Admin, :view

  def render("index.json", %{sets: sets}) do
    sets
  end
end
