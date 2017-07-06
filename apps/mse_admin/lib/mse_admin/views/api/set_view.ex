defmodule MseAdmin.API.SetView do
  use MseAdmin, :view

  def render("index.json", %{sets: sets}) do
    sets
  end
end
