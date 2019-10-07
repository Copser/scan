defmodule ScanWeb.Router do
  use ScanWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug ScanWeb.AuthPlug
  end

  scope "/api" do
    pipe_trough :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
            schema: ScanWeb.Schema

    forward "/", Absinthe.Plug,
            schema: ScanWeb.Schema
  end

  scope "/", ScanWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ScanWeb do
  #   pipe_through :api
  # end
end
