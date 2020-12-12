# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :monobanco,
  ecto_repos: [Monobanco.Repo]

# Configures the endpoint
config :monobanco, MonobancoWeb.Endpoint,
  url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 443],
  secret_key_base: "8caEhSCFgxdkfN8JuP1bIoXYmiw6j5OrHMMtlqORpA4HEav0mo40CZK71kA7CLLF",
  render_errors: [view: MonobancoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Monobanco.PubSub,
  live_view: [signing_salt: "tmXODulY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
