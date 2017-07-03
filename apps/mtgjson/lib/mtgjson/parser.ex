defmodule Mtgjson.Parser do
  def parse(str), do: Poison.decode!(str)

  def parse_from_file(file) do
    {:ok, doc} = File.read(file)

    parse(doc)
  end
end
