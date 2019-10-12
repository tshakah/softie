# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :softie,
  ecto_repos: [Softie.Repo]

# Configures the endpoint
config :softie, SoftieWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v2hnMtmrakv8+KCK+8pFLmibX+TaCg62C3+E9R2O/wdLyt6z936bJhmnf8sBmZ5n",
  render_errors: [view: SoftieWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Softie.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [ signing_salt: "eKPyiSOEt68Rthl1AcS+z+pKgQ8/FIQI" ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
