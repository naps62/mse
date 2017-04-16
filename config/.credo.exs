%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/", "web/", "apps/"],
        excluded: ["apps/frontend"],
      },
      checks: [
        # TODO maybe we want to re-enable this one at some point?
        {Credo.Check.Readability.ModuleDoc, false},
        {Credo.Check.Refactor.PipeChainStart, false},

        {Credo.Check.Consistency.MultiAliasImportRequireUse, false},
      ]
    }
  ]
}
