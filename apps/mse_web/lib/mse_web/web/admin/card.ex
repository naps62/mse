defmodule MseWeb.Web.ExAdmin.Card do
  use ExAdmin.Register

  register_resource DB.Models.Card do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    scope :all, default: true

    query do
      %{show: [preload: [:set]]}
    end

    index do
      column :name, link: true
    end

    show card do
      attributes_table do
        row :name
        row :mtgio_id
        row :set, link: true
      end
    end

    sidebar "", only: :show do
      Phoenix.View.render MseWeb.Web.AdminView, "card_image.html", image: resource.image_url
    end
  end
end
