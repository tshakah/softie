defmodule Softie.Repo do
  use Ecto.Repo,
    otp_app: :softie,
    adapter: Ecto.Adapters.Postgres
end
