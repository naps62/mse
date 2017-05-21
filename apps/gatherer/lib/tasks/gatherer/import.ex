defmodule Mix.Tasks.Gatherer.Import do
  use Mix.Task

  @shortdoc "Import new Gatherer XML data"

  alias DB.{Models.Set, SilentRepo}

  import Ecto.Query

  def run(file) do
    {:ok, _started} = Application.ensure_all_started(:gatherer)

    Mix.shell.info "Importing info from XML"
    Gatherer.import(file)

    Mix.shell.info "New stats:"
    Mix.shell.info "Sets without gatherer data: #{sets_without_gatherer()}"
    # Mix.shell.info "Singles without gatherer data: #{singles_without_gatherer()}"
    # Mix.shell.info "Cards without gatherer data: #{cards_without_gatherer()}"
  end

  defp sets_without_gatherer() do
    Set
    |> where([e], is_nil(e.gatherer_data))
    |> SilentRepo.aggregate(:count, :id)
  end
end
