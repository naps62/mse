defmodule Mse.Web.ExAdmin.Card do
  use ExAdmin.Register

  register_resource DB.Models.Card do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    scope :all, default: true
    scope :no_mtgio_data, &where(&1, [c], is_nil(c.mtgio_data))

    query do
      %{show: [preload: [:set, :single]]}
    end

    index do
      column :name, link: true
    end

    show card do
      attributes_table do
        row :name
        row :mkm_id
        row :mtgio_id
        row :set, link: true
        row :single, link: true
      end
    end

    sidebar "", only: :show do
      Phoenix.View.render Mse.Web.AdminView, "card_image.html", image: resource.image_url
    end
  end
end
