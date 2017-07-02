defmodule Mse.Admin.ExAdmin.Single do
  use ExAdmin.Register

  alias DB.Models.Card
  alias Mse.Admin.Presenters.{Manacost, Ability}
  alias Mse.Admin.Helpers

  register_resource DB.Models.Single do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    scope :all, default: true
    scope :no_gatherer_data, &where(&1, [s], is_nil(s.gatherer_data))
    scope :no_mtgjson_data, &where(&1, [s], is_nil(s.mtgjson_data))
    scope :no_data_at_all, &where(&1, [s], is_nil(s.gatherer_data) and is_nil(s.mtgjson_data))

    query do
      %{show: [preload: [cards: :set]]}
    end

    index do
      column :name, link: true
      column :type
      column :manacost, fn(single) ->
        Manacost.present(single) |> Enum.map(&raw/1)
      end
      column :card_count, &(Helpers.count(where(Card, [c], c.single_id == ^&1.id)))
    end

    show single do
      attributes_table do
        row :name
        row :type
        row :manacost, fn(single) ->
          Manacost.present(single) |> Enum.map(&raw/1)
        end
        row :ability, fn(single) ->
          Ability.present(single) |> Enum.map(&raw/1)
        end
        row :color
        row :power
        row :toughness
      end

      attributes_table "Magic Card Market" do
        row :mkm_id
        row :mkm_updated_at, &Helpers.relative_date(&1.mkm_updated_at)
      end

      panel "Cards" do
        table_for(single.cards) do
          column :name, link: true
          column :set, link: true
          column :rarity
          column :version
          column :artist
        end
      end
    end

    sidebar "", only: :show do
      Phoenix.View.render Mse.AdminView, "card_image.html", image: resource.image_url
    end
  end
end
