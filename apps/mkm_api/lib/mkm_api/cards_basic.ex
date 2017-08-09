defmodule MkmAPI.CardsBasic do
  import Ecto.{Query, Changeset}

  alias DB.{SilentRepo, Models.Card, Models.Set, Models.Single}

  def fetch do
    sets_with_new_cards()
    |> Enum.each(&fetch/1)
  end

  def fetch(%Set{mkm_id: mkm_set_id} = set) do
    cards_data = case MKM.expansion_singles(expansion_mkm_id: mkm_set_id) do
      {:ok, singles} -> singles
      _ -> []
    end

    cards_data
    |> Enum.each(&insert_or_update_card_for_set(set, &1))
    update_set_timestamp(set)
  end

  defp sets_with_new_cards do
    Set
    |> join(:left, [s], c in assoc(s, :cards))
    |> where([s, c], is_nil(c.mkm_basic_updated_at))
    |> select([s, c], s)
    |> SilentRepo.all
  end

  defp insert_or_update_card_for_set(set, card_data) do
    if !card_blacklisted(card_data) do
      MkmApi.CardsBasic.Save.save(set, card_data)
    end
  end

  defp update_set_timestamp(set) do
    changeset = change(set)
    |> put_change(:mkm_cards_updated_at, Timex.now)

    SilentRepo.update(changeset)
  end

  @blacklisted_card_names [
    ~r/Token/,
    ~r/^Rules :/,
    ~r/^Strategy Card:/,
    ~r/^Tip:/,
    ~r/Emblem$/,
    ~r/^Theme:/,
    ~r/^Fun Format:/,
    ~r/ Checklist$/,
    ~r/^Double-Faced Card Proxy Checklist/,
    ~r/ Symbol$/,
    ~r/ Counter$/,
    ~r/^Complete Portal Card List/,
  ]
  defp card_blacklisted(%{"enName" => name}) do
    Enum.any?(@blacklisted_card_names, &Regex.match?(&1, name))
  end
end
