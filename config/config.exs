# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
port = String.to_integer(System.get_env("PORT") || "4000")

# Configures the endpoint
config :wetter, WetterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zwsv9MDx8oymChJlD5y7lKSwkCdYgVQCkSHpE0G3exs3+iicCF8n9Yj1/U/KGG3A",
  render_errors: [view: WetterWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Wetter.PubSub, adapter: Phoenix.PubSub.PG2],
  load_from_system_env: false,
  http: [port: port],
  url: [host: "localhost", port: port]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :sentry,
  dsn: System.get_env("SENTRY_DSN"),
  included_environments: [:prod],
  environment_name: Mix.env(),
  enable_source_code_context: true,
  root_source_code_path: File.cwd!()

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
