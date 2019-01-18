defmodule MkmAPI.Singles.Save do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Single}

  def save(data) do
    insert_or_update(data)
  end

  defp insert_or_update(data) do
    case find_single(data) do
      nil ->
        new_single = %Single{}
        SilentRepo.insert(changeset(new_single, data))

      single ->
        SilentRepo.update(changeset(single, data))
    end
  end

  defp find_single(%{"idMetaproduct" => mkm_id}) do
    Single
    |> where([c], c.mkm_id == ^mkm_id)
    |> SilentRepo.one()
  end

  defp changeset(single, data) do
    change(single)
    |> put_change(:mkm_data, data)
    |> put_change(:mkm_id, data["idMetaproduct"])
    |> put_change(:mkm_updated_at, Timex.now())
    |> put_change(:mkm_double_faced, double_faced?(data))
    |> put_change(:name, data["enName"])
    |> put_change(:image_url, image_url(relative_url: data["image"]))
  end

  defp double_faced?(%{"enName" => name}) do
    Regex.match?(~r|\s/{1,2}\s|, name)
  end

  defp image_url(relative_url: "//static.cardmarket.com" <> _ = full_url),
    do: "https:#{full_url}"

  defp image_url(relative_url: "." <> relative_url),
    do: "https://mkmapi.eu" <> relative_url

  def fix do
    DB.Models.Single
    |> where([s], ilike(fragment("?->>?", s.mkm_data, ^"enName"), "%/%"))
    |> DB.Repo.all()
    |> Enum.each(fn card ->
      change(card)
      |> put_change(:name, card.mkm_data["enName"])
      |> DB.Repo.update()
    end)
  end
end
