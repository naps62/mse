defmodule Mse.Web.ExAdmin.Set do
  use ExAdmin.Register

  register_resource DB.Models.Set do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    scope :all, default: true
    scope :no_mtgio_data, &where(&1, [s], is_nil(s.mtgio_data))

    query do
      %{show: [preload: [:cards]]}
    end

    index do
      column :name, link: true
    end

    show set do
      attributes_table do
        row :name
      end

      panel "Cards" do
        table_for(set.cards) do
          column :name, link: true
        end
      end
    end
  end
end
