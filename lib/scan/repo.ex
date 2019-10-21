defmodule Scan.Repo do
  use Ecto.Repo, otp_app: :scan, adapter: Ecto.Adapters.Postgres
  import Ecto.Query

  def first(query) do
    query
    |> order_by(asc: :id)
    |> limit(1)
    |> Scan.Repo.one
  end

end
