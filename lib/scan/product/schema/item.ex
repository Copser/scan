defmodule Scan.Product.Schema.Item do
  use Scan.Schema
  import Ecto.Changeset

  schema "items" do
    field :qr_id, :string
    field :ean_code, :string
    field :ean, :string
    field :description, :string
    field :category, :string
    field :marketing_text, :string
    field :bullet, :string
    field :brand_image, :string
    field :image, :string
    field :times_scanned, :integer

    timestamps()
  end

  def changeset(item, attrs) do
    item
    |> cast(attrs, [:qr_id, :ean_code, :ean, :description, :category, :marketing_text, :bullet, :brand_image, :image, :times_scanned])
    |> validate_required([:ean_code])
  end
end
