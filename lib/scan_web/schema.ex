defmodule ScanWeb.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types ScanWeb.Schema.ProfileTypes
  import_types ScanWeb.Schema.ViewerTypes
  import_types ScanWeb.Schema.ProductTypes

  alias Scan.Profile

  query do
    field :me, :viewer do
      resolve fn (_, _, %{context: %{viewer: viewer}}) ->
        {:ok, viewer}
      end
    end

    field :user, :user do
      arg :id, :id, default_value: "me"

      resolve fn _, %{id: id}, %{context: %{viewer: viewer}} ->
        id = if id == "me" do viewer.id else id end

        Profile.get!(viewer, id)
      end
    end
  end

  mutation do
    import_fields :profile_mutations
    import_fields :product_mutations
  end

  def context(ctx) do
    source = Dataloader.Ecto.new(Tms.Repo)

    loader =
      Dataloader.new
      |> Dataloader.add_source(:db, source)

    viewer = ctx[:viewer]

    ctx
    |> Map.put(:loader, loader)
    |> Map.put(:viewer, viewer)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [ScanWeb.ErrorMiddleware]
  end

  def middleware(middleware, _field, _object), do: middleware
end
