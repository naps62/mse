defmodule Mse.Web.ExAdmin.Set do
  use ExAdmin.Register

  alias DB.Models.Card
  alias MseWeb.Presenters.Manacost
  alias MseWeb.Admin.Helpers

  register_resource DB.Models.Set do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    scope :all, default: true
    scope :no_mtgio_data, &where(&1, [s], is_nil(s.mtgio_data))
    scope :no_gatherer_data, &where(&1, [s], is_nil(s.gatherer_data))

    query do
      %{show: [preload: [cards: :single]]}
    end

    index do
      column :name, link: true
      column :card_count, &(Helpers.count(where(Card, [c], c.set_id == ^&1.id)))
    end

    show set do
      attributes_table do
        row :name
      end

      attributes_table "Magic Card Market" do
        row :mkm_id
        row :mkm_name
        row :mkm_code
        row :mkm_updated_at
        row :mkm_cards_updated_at
      end

      attributes_table "Gatherer" do
        row :gatherer_code
        row :gatherer_updated_at
      end

      attributes_table "MTGIO" do
        row :mtgio_id
      end

      panel "Cards" do
        table_for(set.cards) do
          column :name, link: true
          column :manacost, fn(card) ->
            Manacost.present(card.single.manacost) |> Enum.map(&raw/1)
          end
          column :rarity
          column :version
          column :artist
        end
      end
    end
  end
end
