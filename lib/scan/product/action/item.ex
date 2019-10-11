defmodule Scan.Product.Action.Item do
  use Ecto.Schema
  import Ecto.Query
  alias Scan.Repo
  alias Scan.Product.Schema.Item


  def get_product(%{ean_code: ean_code}) when ean_code != nil do
    item =
     Item
      |> where([t], t.ean_code == ^ean_code)
      |> Repo.all

    {:ok, item}
  end
end
