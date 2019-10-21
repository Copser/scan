defmodule Scan.Profile.Reset do
  use Ecto.Schema
  import Ecto.Query
  import Swoosh.Email, except: [from: 2]

  alias Scan.Repo
  alias Scan.Profile.Schema.User

  def reset_password_request(%{email: email}) do
    password_reset_code = Enum.random(100000..999999) |> to_string

    user =
      User
      |> Repo.get_by!(email: email)
      |> User.changeset(%{password_reset_code: password_reset_code})
      |> Repo.update!

    # TODO: Setup server on Postmark add template id and alias
    new()
    |> Swoosh.Email.from("no-reply@scanme.com")
    |> to(email)
    |> put_provider_option(:template_id, "")
    |> put_provider_option(:template_alias, "")
    |> put_provider_option(:template_model, %{code: user.password_reset_code, name: user.name})
    |> Scan.Mailer.deliver()

    {:ok, user}
  end

  def reset_password(%{code: code, email: email, password: password}) when code != nil do

    user =
      User
      |> where([t], t.password_reset_code == ^code)
      |> where([t], t.email == ^email)
      |> Repo.one

    if user do
      User.changeset(user, %{password: password, password_reset_code: nil})
      |> Repo.update

      {:ok, ""}
    else
      {:error, "Invalid email or code"}
    end
  end
end
