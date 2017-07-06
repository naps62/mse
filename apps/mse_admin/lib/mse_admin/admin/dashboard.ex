defmodule MseAdmin.ExAdmin.Dashboard do
  use ExAdmin.Register

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"

    content do
      Phoenix.View.render(MseAdmin.AdminView, "actions.html", conn: conn)
    end
  end
end
