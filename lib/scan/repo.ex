defmodule Scan.Repo do
  use Ecto.Repo,
    otp_app: :scan,
    adapter: Ecto.Adapters.Postgres
end
