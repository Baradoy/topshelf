defmodule Topshelf.Inventory.Shelf do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shelves" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(shelf, attrs) do
    shelf
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
