defmodule Gatherer.Singles do
  alias DB.{SilentRepo, Models.Single}

  import Ecto.Query
  import Ecto.Changeset

  def import do
    SilentRepo
    |> DB.Stream.stream(Single)
    |> Stream.each(&update_single/1)
    |> Stream.run
  end

  defp update_single(single) do
    change(single)
    |> put_change(:type, field_in_cards(single, :type))
    |> put_change(:manacost, field_in_cards(single, :manacost))
    |> put_change(:ability, field_in_cards(single, :ability))
    |> put_change(:color, field_in_cards(single, :color))
    |> put_change(:power, field_in_cards(single, :power, :integer))
    |> put_change(:toughness, field_in_cards(single, :toughness, :integer))
    |> put_change(:gatherer_data, %{})
    |> SilentRepo.update
  end

  defp field_in_cards(single, field, :integer) do
    case field_in_cards(single, field) do
      nil -> nil
      str ->
        case Integer.parse(str) do
          {result, _} -> result
          _ -> nil
        end
    end
  end

  defp field_in_cards(single, field) do
    single
    |> Ecto.assoc(:cards)
    |> select([c], fragment("?->>?", c.gatherer_data, ^to_string(field)))
    |> SilentRepo.all
    |> Enum.find(&valid_value?/1)
  end

  defp valid_value?(nil), do: false
  defp valid_value?(str) do
    (str
    |> String.trim
    |> String.length) > 0
  end
end
