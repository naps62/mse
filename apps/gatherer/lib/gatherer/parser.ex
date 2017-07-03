defmodule Gatherer.Parser do
  import SweetXml

  defstruct doc: ""

  @set_fields [
    :name,
    :code,
    :code_magiccards,
  ]

  @card_fields [
    :id,
    :name,
    :set,
    :type,
    :rarity,
    :manacost,
    :converted_manacost,
    :power,
    :toughness,
    :loyalty,
    :ability,
    :flavor,
    :variation,
    :artist,
    :number,
    :rating,
    :ruling,
    :color,
    :generated_mana,
    :color_identity,
    :name_CN,
    :name_TW,
    :name_FR,
    :name_DE,
    :name_IT,
    :name_JP,
    :name_PT,
    :name_RU,
    :name_ES,
    :name_KO,
  ]

  @set_schema Enum.map(@set_fields, &({&1, ~x"./#{&1}/text()"S}))

  @card_schema Enum.map(@card_fields, &({&1, ~x"./#{&1}/text()"S}))

  def new({:inline, str}) do
    %__MODULE__{doc: str}
  end

  def new(file) do
    {:ok, doc} = File.read(file)

    %__MODULE__{doc: doc}
  end

  def sets(%__MODULE__{doc: doc}) do
    doc
    |> xmap(sets: [~x"//sets/set"l | @set_schema])
    |> Map.get(:sets)
  end

  def cards(%__MODULE__{doc: doc}) do
    doc
    |> xmap(cards: [~x"//cards/card"l | @card_schema])
    |> Map.get(:cards)
  end
end
