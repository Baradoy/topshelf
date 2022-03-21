defmodule Topshelf.Cocktails.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> cast(attrs, [:volume])
    |> cast_assoc(:recipe)
    |> cast_assoc(:bottle)
    |> validate_required([:volume])
  end
end
