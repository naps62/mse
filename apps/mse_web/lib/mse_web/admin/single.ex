defmodule Mse.Web.ExAdmin.Single do
  use ExAdmin.Register

  register_resource DB.Models.Single do
    clear_action_items!()
    action_items only: [:show]

    filter only: [:name]

    index do
      column :name, link: true
    end

    show set do
      attributes_table do
        row :name
      end
    end
  end
end
