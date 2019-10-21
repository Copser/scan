defmodule ScanWeb.Schema.ProductTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias Scan.Product

  object :item do
    field :qr_id, :string
    field :ean_code, :string
    field :ean, :string
    field :description, :string
    field :category, :string
    field :marketing_text, :string
    field :bullet, :string
    field :brand_image, :string
    field :image, :string
  end


  # ===============================================================
  #                              MUTATIONS
  # ===============================================================

  object :product_mutations do

    field :item, type: :item do
      arg :ean_code, non_null(:string)

      resolve fn _, args, _ ->
        Product.get_product(args)
      end
    end
  end
end
