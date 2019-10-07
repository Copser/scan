# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :scan,
  ecto_repos: [Scan.Repo]

config :scan,
  migration_primary_key: [name: :id, type: :binary_id]

# Configures the endpoint
config :scan, ScanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VU8hGGp7LIBGVFCzolK+lsmBTARb1HPcsWbRqLje5OIHnZIqA4cU1YqrSA6SgX/Z",
  render_errors: [view: ScanWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Scan.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Joken Token config
config :joken, default_signer: [
  signer_alg: "HS256",
  key_octet: "cuastv23dsqwdffnhjhdbkcbakjasqkfwir123o8r83bufbfbf1b"
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
