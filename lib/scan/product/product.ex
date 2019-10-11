defmodule Scan.Product do
  alias Scan.Product.Action

  defdelegate get_product(ean_code), to: Action.Item
end
