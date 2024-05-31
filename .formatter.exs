[
  import_deps: ~w[
    ecto
    ecto_sql
    phoenix
    ash
    ash_postgres
    ash_phoenix
    ash_authentication
    ash_authentication_phoenix
  ]a,
  subdirectories: ["priv/*/migrations"],
  plugins: [TailwindFormatter, Phoenix.LiveView.HTMLFormatter, Styler],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}", "priv/*/seeds.exs"]
]
