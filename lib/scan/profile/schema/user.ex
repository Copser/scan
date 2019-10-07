defmodule Scan.Profile.Schema.User do
  use Scan.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string

    field :password_reset_code, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :password_reset_code])
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6, message: "Password should be at leaset 6 characters")
    |> update_change(:email, &String.trim/1)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/[^@]+@[^\.]+\..+/)
    |> hash_password()
  end

  def create_changeset(account, attrs) do
    account
    |> changeset(attrs)
    |> validate_required([:password])
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    changeset
    |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))
  end
end
