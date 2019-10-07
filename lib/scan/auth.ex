defmodule Scan.Auth do
  import Ecto.Query

  alias Scan.Repo
  alias Scan.Token
  alias Scan.Profile.Schema.User

  def login(email, password) do
    user =
      User
      |> where([t], t.email == ^email)
      |> Repo.one

    has_valid_password = Bcrypt.verify_pass(password, (if user, do: user.password_hash, else: ""))

    if user && has_valid_password do
      {:ok, token, _} = Token.generate_and_sign(%{"id" => user.id})

      {:ok, %{token: token, user: user}}
    else
      {:error, "Invalid email or password"}
    end
  end

  def get_user_for_token(token) do
    case Token.verify_and_validate(token) do
      {:ok, %{"id" => id}} -> {:ok, Repo.get!(User, id)}
      _ -> {:error, "Invalid token"}
    end
  end
end
