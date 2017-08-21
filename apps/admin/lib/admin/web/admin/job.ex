defmodule Admin.Web.ExAdmin.Job do
  use ExAdmin.Register

  alias Admin.Web.Helpers

  register_resource DB.Models.Job do
    clear_action_items!()

    index do
      column :module
      column :name
      column :status
      column :inserted_at, &Helpers.relative_date(&1.inserted_at)
      column :updated_at, &Helpers.relative_date(&1.updated_at)
    end
  end
end
