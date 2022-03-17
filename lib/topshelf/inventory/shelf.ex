defmodule Topshelf.Inventory.Shelf do
  use Ecto.Schema
  import Ecto.Changeset

  alias Topshelf.Inventory.Bottle

  schema "shelves" do
    field :description, :string
    field :name, :string
    has_many :bottles, Bottle

    timestamps()
  end

  @doc false
  def changeset(shelf, attrs) do
    shelf
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
