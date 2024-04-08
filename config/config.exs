# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :onesen,
  ecto_repos: [Onesen.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :onesen, OnesenWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: OnesenWeb.ErrorHTML, json: OnesenWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Onesen.PubSub,
  live_view: [signing_salt: "UNXq8qbZ"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :onesen, Onesen.Mailer, adapter: Swoosh.Adapters.Local

config :bun,
  version: "1.1.2",
  default: [
    args:
      ~w(build js/app.js --outdir=../priv/static/assets --external /fonts/* --external /images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.0",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
