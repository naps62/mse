defmodule MkmAPI.Singles.Save do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Single}

  def save(data) do
    if single_is_double_faced?(data) do
      insert_or_update(data, double_faced: true, back_face: false)
      insert_or_update(data, double_faced: true, back_face: true)
    else
      insert_or_update(data, double_faced: false, back_face: true)
    end
  end

  defp single_is_double_faced?(%{"enName" => name}) do
    Regex.match?(~r|\s/{1,2}\s|, name)
  end

  defp insert_or_update(data, double_faced: double_faced, back_face: back_face) do
    case find_single(data, double_faced: double_faced, back_face: back_face) do
      nil ->
        new_single = %Single{mkm_double_faced: double_faced, mkm_back_face: back_face}
        SilentRepo.insert(changeset(new_single, data))
      single ->
        SilentRepo.update(changeset(single, data))
    end
  end

  defp find_single(%{"idMetaproduct" => mkm_id}, double_faced: double_faced, back_face: back_face) do
    Single
    |> where(
      [c],
      c.mkm_id == ^mkm_id and
      c.mkm_double_faced == ^double_faced and
      c.mkm_back_face == ^back_face
    )
    |> SilentRepo.one
  end

  defp changeset(single, data) do
    change(single)
    |> put_change(:mkm_data, data)
    |> put_change(:mkm_id, data["idMetaproduct"])
    |> put_change(:mkm_updated_at, Timex.now)
    |> put_change(:name, data["enName"])
    |> put_change(:name, name_for_single(single, data["enName"]))
    |> put_change(:image_url, image_url(relative_url: data["image"]))
  end

  defp name_for_single(single, name) do
    cond do
      double_faced?(single) and back_face?(single) ->
        Regex.run(~r|/+\s+(.+)$|, name)
        |> Enum.at(1)
      double_faced?(single) and not back_face?(single) ->
        Regex.run(~r|^(.+)\s+/+|, name)
        |> Enum.at(1)
      true ->
        name
    end
  end

  defp double_faced?(%Single{mkm_double_faced: double_faced}), do: double_faced
  defp back_face?(%Single{mkm_back_face: back_face}), do: back_face

  defp image_url(relative_url: "." <> relative_url), do:
    "https://mkmapi.eu" <> relative_url
end
