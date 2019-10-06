defmodule Scan.Token do
  use Joken.Config

  def token_config do
    default_claims(default_exp: 60 * 60 * 24 *10 \\ []) # 10 days
    |> Map.delete("iss")
    |> Map.delete("aud")
  end
end
