defmodule Scan.Profile do
  alias Scan.Profile.Action

  defdelegate get!(id), to: Action.User

  defdelegate register_user(user_params), to: Action.User
  defdelegate update_profile(viewer, user_params), to: Action.User

  def first do
    Scan.Profile.Schema.User |> Scan.Repo.first
  end
end
