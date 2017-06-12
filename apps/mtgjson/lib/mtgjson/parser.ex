defmodule Mtgjson.Parser do
  def parse(file) do
    {:ok, doc} = File.read(file)

    Poison.decode!(doc)
  end
end
