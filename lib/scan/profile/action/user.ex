defmodule Scan.Profile.Action.User do
  alias Scan.Token
  alias Scan.Repo
  alias Scan.Profile.Schema.User

  def get!(id), do: Repo.get!(User, id)

    def register_user(user_params) do
			user =
				%User{}
				|> User.create_changeset(user_params)
				|> Repo.insert

			case user do
				 {:ok, user } ->
				 	{:ok, token, _} = Token.generate_and_sign(%{"id" => user.id })
					{:ok, %{token: token, user: user}}

				other -> other
			end
    end

		def update_profile(viewer, user_params) do
			viewer
			|> User.changeset(user_params)
			|> Repo.update
		end
end
