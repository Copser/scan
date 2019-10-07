defmodule ScanWeb.Schema.ProfileTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias Scan.Profile

  object :user do
    field :id, :id
    field :name, :string

    field :is_me, :boolean do
      resolve fn (user, _, %{context: %{viewer: viewer}}) ->
        {:ok, viewer.id == user.id}
      end
    end
  end

  object :login_result do
    field :ok, :boolean
    field :token, :string
    field :user_id, :id
  end

  # ===============================================================
  #                              INPUT
  # ===============================================================

  input_object :profile_input do
    field :name, :string
    field :email, :string
    field :password, :string
  end

  # ===============================================================
  #                              MUTATIONS
  # ===============================================================
  object :profile_mutations do

    field :login, type: :login_result do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve fn _, args, _ ->
        case Scan.Auth.login(args.email, args.password) do
          {:ok, %{user: user, token: token}} -> {:ok, %{token: token, ok: true}}
          t -> t
        end
      end
    end

    field :reset_password_request, type: :string do
      arg :email, non_null(:string)

      resolve fn _, args, _ ->
        Scan.Profile.Reset.reset_password_request(args)
        {:ok, ""}
      end
    end

    field :reset_password, type: :string do
      arg :code, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve fn _, args, _ ->
        Scan.Profile.Reset.reset_password(args)
      end
    end

    field :update_profile, type: :user do
      arg :user, :profile_input

      resolve fn _, %{user: user}, %{context: %{viewer: viewer}} ->
        Profile.update_profile(viewer, user)
      end
    end

    field :register_user, type: :login_result do
      arg :name, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve fn _, args, _ ->
        Profile.register_user(args)
      end
    end
  end
end
