defmodule Topshelf.Inventory.Bottle do
  use Ecto.Schema
  import Ecto.Changeset

  alias Topshelf.Inventory.Shelf

  schema "bottles" do
    field :abv, :float
    field :brand, :string
    field :description, :string
    field :name, :string
    field :type, :string
    field :url, :string
    field :volume, :string
    belongs_to :shelf, Shelf

    timestamps()
  end

  @doc false
  def changeset(bottle, attrs) do
    bottle
    |> cast(attrs, [:brand, :name, :type, :description, :volume, :abv, :url, :shelf_id])
    |> validate_required([:name, :shelf_id])
  end
end
