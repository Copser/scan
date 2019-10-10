defmodule Scan.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :qr_id, :string
      add :ean_code, :string
      add :ean, :string
      add :description, :string
      add :category, :string
      add :marketing_text, :string
      add :bullet, :string
      add :brand_image, :string
      add :image, :string
      add :times_scanned, :integer

      timestamps()
    end

    create unique_index(:items, [:ean_code])
  end
end
