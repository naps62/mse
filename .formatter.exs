# Used by "mix format"
[
  inputs: [
    "mix.exs",
    "apps/*/mix.exs",
    "apps/*/{config,lib,test}/**/*.{ex,exs}"
  ],
  line_length: 80,
  locals_without_parens: [
    # elixir
    defstruct: :*,
    defmodule: :*,

    # vex
    validates: :*,

    # plug
    plug: :*,
    forward: :*,
    get: :*,
    post: :*,
    patch: :*,
    put: :*,
    delete: :*,

    # phoenix
    pipe_through: :*,
    socket: :*,
    adapter: :*
  ]
]
