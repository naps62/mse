defmodule Admin.Web.ExAdmin.Dashboard do
  use ExAdmin.Register
  alias DB.Models.{Card, Set, Single}
  alias DB.Repo
  import Ecto.Query

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"

    content do
      Phoenix.View.render(
        Admin.Web.AdminView,
        "dashboard.html",
        conn: conn,
        general_stats: general_stats(),
        mkm_stats: mkm_stats(),
        mtgjson_stats: mtgjson_stats(),
        gatherer_stats: gatherer_stats()
      )
    end
  end

  defp general_stats do
    %{
      "# Sets" =>
        Repo.one(from s in Set, select: count(s.id)),
      "# Cards" =>
        Repo.one(from c in Card, select: count(c.id)),
      "# Singles" =>
        Repo.one(from s in Single, select: count(s.id)),
    }
  end

  defp mkm_stats do
    %{
      "Cards w/o basic data" =>
        Repo.one(from c in Card, where: is_nil(c.mkm_basic_data), select: count(c.id)),
      "Cards w/o detailed data" =>
        Repo.one(from c in Card, where: is_nil(c.mkm_detailed_data), select: count(c.id)),
      "Cards w/o single" =>
        Repo.one(from c in Card, where: is_nil(c.single_id), select: count(c.id)),
    }
  end

  defp mtgjson_stats do
    %{
      "Sets w/o data" =>
        Repo.one(from s in Set, where: is_nil(s.mtgjson_data), select: count(s.id)),
      "Cards w/o data" =>
        Repo.one(from c in Card, where: is_nil(c.mtgjson_id), select: count(c.id)),
      "Singles w/o data" =>
        Repo.one(from s in Single, where: is_nil(s.mtgjson_name), select: count(s.id)),
    }
  end

  defp gatherer_stats do
    %{
      "Sets w/o data" =>
        Repo.one(from s in Set, where: is_nil(s.gatherer_code), select: count(s.id)),
      "Cards w/o data" =>
        Repo.one(from c in Card, where: is_nil(c.gatherer_id), select: count(c.id)),
    }
  end
end
