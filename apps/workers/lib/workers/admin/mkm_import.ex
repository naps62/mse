defmodule Workers.Admin.MKMImport do
  def perform do
    MkmAPI.Sets.fetch
    MkmAPI.CardsBasic.fetch
    MkmAPI.CardsDetailed.fetch(:new)
    MkmAPI.Singles.fetch
  end
end
