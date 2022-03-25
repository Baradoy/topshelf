defmodule Topshelf.Inventory.Bottle do
  use Ecto.Schema
  import Ecto.Changeset
  import Topshelf.Measurements, only: [validate_measurement: 2]

  alias Topshelf.Cocktails.Ingredient
  alias Topshelf.Inventory.Shelf

  schema "bottles" do
    field :abv, :float
    field :remaining_percent, :integer
    field :brand, :string
    field :description, :string
    field :name, :string
    field :type, :string
    field :image_url, :string
    field :volume, :string

    belongs_to :shelf, Shelf
    has_many :ingredients, Ingredient

    timestamps()
  end

  @doc false
  def changeset(bottle, attrs) do
    bottle
    |> cast(attrs, [
      :brand,
      :name,
      :type,
      :description,
      :volume,
      :abv,
      :image_url,
      :shelf_id,
      :remaining_percent
    ])
    |> validate_required([:name, :shelf_id])
    |> validate_measurement(:volume)
  end
end
