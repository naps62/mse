defmodule Gatherer do
  def import(file) do
    data = Gatherer.Parser.new(file)

    set_data = Gatherer.Parser.sets(data)
    card_data = Gatherer.Parser.cards(data)

    Gatherer.Sets.import(set_data)
    Gatherer.Cards.import(card_data)
    Gatherer.Singles.import
  end
end
