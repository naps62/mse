defmodule MseWeb.Web.ExAdmin.Set do
  use ExAdmin.Register

  register_resource DB.Models.Set do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    scope :all, default: true

    query do
      %{show: [preload: [:cards]]}
    end

    index do
      column :name, link: true
    end

    show set do
      attributes_table do
        row :name
        row :mtgio_id
      end

      panel "Cards" do
        table_for(set.cards) do
          column :name, link: true
        end
      end
    end
  end
end
