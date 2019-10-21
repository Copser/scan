defmodule ScanWeb.AuthPlug do
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    conn
    |> authorize(get_req_header(conn, "authorization"))
    |> put_private(:absinthe, %{context: %{viewer: Scan.Profile.first}})
  end

  def authorize(conn, ["Bearer " <> token]) do
    case Scan.Auth.get_user_for_token(token) do
      {:ok, user} ->
        conn
        |> put_private(:absinthe, %{context: %{viewer: user}})

      {:error, _} ->
        conn
        |> send_resp(403, "Invalid Token")
        |> halt
    end
  end

  def authorize(conn, _), do: conn
end
