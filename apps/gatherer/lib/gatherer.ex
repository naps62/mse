defmodule Gatherer do
  def import(file) do
    data = Gatherer.Parser.new(file)

    IO.puts("Parsing #{file}")
    set_data = Gatherer.Parser.sets(data)
    card_data = Gatherer.Parser.cards(data)

    IO.puts("Importing sets #{file}")
    Gatherer.Sets.import(set_data)

    IO.puts("Importing cards #{file}")
    Gatherer.Cards.import(card_data)

    # IO.puts "Importing singles #{file}"
    # Gatherer.Singles.import
  end
end
