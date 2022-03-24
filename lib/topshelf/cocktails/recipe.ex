defmodule Topshelf.Cocktails.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias Topshelf.Cocktails.Ingredient

  schema "recipes" do
    field :directions, :string
    field :image_url, :string
    field :name, :string

    has_many :ingredients, Ingredient, on_replace: :delete

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
end
