defmodule Admin.Web.ExAdmin.Card do
  use ExAdmin.Register

  alias Admin.Web.Presenters.Manacost
  alias Admin.Web.Helpers

  register_resource DB.Models.Card do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    scope :all, default: true
    scope :no_gatherer_data, &where(&1, [c], is_nil(c.gatherer_data))
    scope :no_mtgjson_data, &where(&1, [c], is_nil(c.mtgjson_data))
    scope :no_data_at_all, &where(&1, [c], is_nil(c.gatherer_data) and is_nil(c.mtgjson_data))
    scope :no_single, &where(&1, [c], is_nil(c.single_id))
    scope :no_detailed_data, &where(&1, [c], is_nil(c.mkm_detailed_data))

    query do
      %{
        index: [preload: [:single]],
        show: [preload: [:set, :single]]
      }
    end

    index do
      column :name, link: true
      column :manacost, fn(card) ->
        Manacost.present(card.single) |> Enum.map(&raw/1)
      end
      column :mkm_price_trend
      column :mkm_detailed_updated_at, &Helpers.relative_date(&1.mkm_detailed_updated_at)
    end

    show card do
      attributes_table "Card" do
        row :name
        row :mkm_name
        row :mkm_id
        row :set, link: true
        row :single, link: true
        row :mkm_double_faced
        row :mkm_back_face
        row :artist
        row :rarity
      end

      attributes_table "Magic Card Market" do
        row :mkm_id
        row :mkm_price_trend
        row :mkm_url
        row :mkm_basic_updated_at, &Helpers.relative_date(&1.mkm_basic_updated_at)
        row :mkm_detailed_updated_at, &Helpers.relative_date(&1.mkm_detailed_updated_at)
      end

      attributes_table "Gatherer" do
        row :gatherer_id
        row :gatherer_updated_at, &Helpers.relative_date(&1.gatherer_updated_at)
      end

      if card.single do
        attributes_table "Single" do
          row :single, link: true
          row :type, &(&1.single |> Map.get(:type))
          row :manacost, fn(card) ->
            Manacost.present(card.single) |> Enum.map(&raw/1)
          end
          row :ability, &(&1.single.ability || "")
          row :color, &(&1.single.color || "")
          row :power, &(to_string(&1.single.power || ""))
          row :toughness, &(to_string(&1.single.toughness || ""))
        end
      end
    end

    sidebar "", only: :show do
      Phoenix.View.render Admin.Web.AdminView, "card_image.html", image: resource.image_url
    end
  end
end
