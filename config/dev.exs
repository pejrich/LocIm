use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :loc_im, LocIm.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin"]]

# Watch static and templates for browser reloading.
config :loc_im, LocIm.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
# config :logger, :console, format: "[$level] $message\n"

config :logger, format: "[$level] $message\n",
  backends: [{LoggerFileBackend, :info},
             {LoggerFileBackend, :error}, :console]

config :logger, :info,
  path: "logg/info.log",
  level: :info

config :logger, :error,
  path: "logg/error.log",
  level: :error

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :loc_im, LocIm.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "perich",
  password: "postgres",
  database: "loc_im_dev",
  hostname: "localhost",
  pool_size: 10,
  extensions: [{Geo.PostGIS.Extension, library: Geo}]
