defmodule Mtgjson do
  @base_url "https://mtgjson.com/json/"

  @mappings %{
    "AllSets.json.zip" => &Mtgjson.Sets.import/1,
    "AllCards.json.zip" => &Mtgjson.Singles.import/1,
  }

  def download_and_import do
    @mappings
    |> Enum.each(&process_remote_zip/1)
  end

  @spec process_remote_zip({String.t, (String.t -> any)}) :: any
  defp process_remote_zip({filename, handler}) do
    with {:ok, response} <- HTTPoison.get(@base_url <> filename),
      {:ok, [{_, inflated_data}]} <- inflate(response.body)
    do
      IO.inspect filename
      IO.inspect handler
      handler.({:data, inflated_data})
    end
  end

  @spec inflate(binary) :: String.t
  defp inflate(zipped_binary) do
    zipped_binary
    |> :zip.extract([:memory])
  end
end
