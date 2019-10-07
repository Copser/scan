defmodule ScanWeb.Schema.ViewerTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias Scan.Profile

  object :viewer do
    field :id, :id
    field :name, :string
    field :email, :string
  end
end
