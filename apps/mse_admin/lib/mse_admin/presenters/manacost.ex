defmodule MseAdmin.Presenters.Manacost do
  alias Phoenix.HTML

  alias DB.Models.Single

  @mana_icon_regex ~r/\{([0-9A-Z]+)\}/

  def present(nil), do:
    [HTML.Tag.content_tag(:span, "", class: "ManaIcon placeholder")]

  def present(%Single{manacost: manacost}) do
    present(manacost)
  end

  def present(str) do
    String.split(str, @mana_icon_regex, include_captures: true)
    |> Enum.map(&single_mana_image/1)
  end

  defp single_mana_image(str) do
    if String.match?(str, @mana_icon_regex) do
      HTML.Tag.content_tag :span, "", class: "ManaIcon sprite-#{String.at(str, 1)}"
    else
      HTML.Tag.content_tag :span, HTML.raw(str)
    end
  end
end
