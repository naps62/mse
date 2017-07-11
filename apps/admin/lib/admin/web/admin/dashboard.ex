defmodule Admin.Web.ExAdmin.Dashboard do
  use ExAdmin.Register

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"

    content do
      Phoenix.View.render(Admin.Web.AdminView, "actions.html", conn: conn)
    end
  end
end
