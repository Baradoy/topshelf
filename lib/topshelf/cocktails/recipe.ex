defmodule Topshelf.Cocktails.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias Topshelf.Cocktails.Ingredient
  alias Topshelf.Measurements

  schema "recipes" do
    field :directions, :string
    field :image_url, :string
    field :name, :string
    field :available?, :boolean, virtual: true, default: true

    has_many :ingredients, Ingredient, on_replace: :delete, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :image_url, :directions])
    |> cast_assoc(:ingredients)
    |> validate_required([:name])
    |> validate_length(:directions, min: 1)
  end

  def put_available(%__MODULE__{} = recipe) do
    available? =
      Enum.all?(
        recipe.ingredients,
        fn ingredient ->
          ingredient.bottle.volume
          |> Measurements.to_measure()
          |> Measurements.percent_of_measure(ingredient.bottle.remaining_percent / 100.0)
          |> Measurements.can_pour?(ingredient.volume)
        end
      )

    %{recipe | available?: available?}
  end
end
