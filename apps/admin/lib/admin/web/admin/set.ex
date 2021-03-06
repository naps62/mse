defmodule Admin.Web.ExAdmin.Set do
  use ExAdmin.Register

  alias DB.Models.Card
  alias Admin.Web.Presenters.Manacost
  alias Admin.Web.Helpers

  register_resource DB.Models.Set do
    clear_action_items!()
    action_items(only: [:show])

    filter(only: [:name])

    scope(:all, default: true)
    scope(:no_gatherer_data, &where(&1, [s], is_nil(s.gatherer_data)))
    scope(:no_mtgjson_data, &where(&1, [s], is_nil(s.mtgjson_data)))

    scope(
      :no_data_at_all,
      &where(&1, [s], is_nil(s.gatherer_data) and is_nil(s.mtgjson_data))
    )

    query do
      %{show: [preload: []]}
    end

    index do
      column(:name, link: true)
      column(:mkm_code)
      column(:gatherer_code)
      column(:mtgjson_codes)

      column(
        :card_count,
        [label: "Cards"],
        &Helpers.count(where(Card, [c], c.set_id == ^&1.id))
      )

      column(
        :cards_without_gatherer,
        [label: "Cards w/o Gatherer"],
        &Helpers.count(
          where(Card, [c], c.set_id == ^&1.id and is_nil(c.gatherer_data))
        )
      )

      column(
        :cards_without_mtgjson,
        [label: "Cards w/o Mtgjson"],
        &Helpers.count(
          where(Card, [c], c.set_id == ^&1.id and is_nil(c.mtgjson_data))
        )
      )
    end

    show set do
      attributes_table do
        row(:name)
      end

      attributes_table "Magic Card Market" do
        row(:mkm_id)
        row(:mkm_name)
        row(:mkm_code)
        row(:mkm_updated_at)

        row(
          :mkm_cards_updated_at,
          &Helpers.relative_date(&1.mkm_cards_updated_at)
        )
      end

      attributes_table "Mtgjson" do
        row(:mtgjson_codes)
      end

      attributes_table "Gatherer" do
        row(:gatherer_code)

        row(
          :gatherer_updated_at,
          &Helpers.relative_date(&1.gatherer_updated_at)
        )
      end

      panel "Cards" do
        ordered_cards =
          Ecto.assoc(set, :cards)
          |> order_by(:name)
          |> preload(:single)
          |> DB.Repo.all()

        table_for ordered_cards do
          column(:name, link: true)

          column(:manacost, fn card ->
            Manacost.present(card.single) |> Enum.map(&raw/1)
          end)

          column(:rarity)
          column(:version)
          column(:artist)
        end
      end
    end
  end
end
