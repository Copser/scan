defmodule Scan.Advert.Action.Commercial do
  use Scan.Schema
  import Ecto.Changeset

  schema "commercials" do
    field :url, :string
    field :image_container, :string

    timestamps()
  end

  def changeset(commercial, attrs) do
    commercial
    |> cast(attrs, [:url, :image_container])
    |> validate_required([:url])
  end
end
