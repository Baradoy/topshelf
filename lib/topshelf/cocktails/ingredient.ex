defmodule Topshelf.Cocktails.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  import Topshelf.Measurements, only: [validate_measurement: 2]

  alias Topshelf.Cocktails.Recipe
  alias Topshelf.Inventory.Bottle

  schema "ingredients" do
    field :volume, :string

    belongs_to :recipe, Recipe
    belongs_to :bottle, Bottle

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:volume, :bottle_id])
    |> validate_required([:volume, :bottle_id])
    |> validate_measurement(:volume)
  end
end
