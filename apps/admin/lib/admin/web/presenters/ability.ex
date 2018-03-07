defmodule Admin.Web.Presenters.Ability do
  alias DB.Models.Single

  def present(nil), do: []
  def present(%Single{ability: nil}), do: []

  def present(%Single{ability: str}) do
    str
    |> String.replace("£", "<br />")
    |> String.replace("#_", "<i>")
    |> String.replace("_#", "</i>")
    |> Admin.Web.Presenters.Manacost.present()
  end
end
