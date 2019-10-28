defmodule Scan.Repo.Migrations.CreateAdverts do
  use Ecto.Migration

  def change do
    create table(:adverts) do
      add :url, :string

      timestamps()
    end

    create index(:adverts, [:url])
  end
end
