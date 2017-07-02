defmodule MseWeb.API.SetView do
  use MseWeb, :view

  def render("index.json", %{sets: sets}) do
    sets
  end
end
