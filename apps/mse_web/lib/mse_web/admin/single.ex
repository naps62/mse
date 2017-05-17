defmodule Mse.Web.ExAdmin.Single do
  use ExAdmin.Register

  register_resource DB.Models.Single do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    query do
      %{show: [preload: [:cards]]}
    end

    index do
      column :name, link: true
    end

    show single do
      attributes_table do
        row :name
        row :mkm_id
        row :mtgio_id
      end

      panel "Cards" do
        table_for(single.cards) do
          column :name, link: true
        end
      end
    end

    sidebar "", only: :show do
      Phoenix.View.render Mse.Web.AdminView, "card_image.html", image: resource.image_url
    end
  end
end
