defmodule Topshelf.Inventory.Bottle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bottles" do
    field :abv, :float
    field :brand, :string
    field :description, :string
    field :name, :string
    field :type, :string
    field :url, :string
    field :volume, :string
    field :shelf_id, :id

    timestamps()
  end

  @doc false
  def changeset(bottle, attrs) do
    bottle
    |> cast(attrs, [:brand, :name, :type, :description, :volume, :abv, :url])
    |> validate_required([:brand, :name, :type, :description, :volume, :abv, :url])
  end
end
