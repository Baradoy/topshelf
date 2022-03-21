defmodule Topshelf.Cocktails.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recipes" do
    field :directions, :string
    field :image_url, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :image_url, :directions])
    |> validate_required([:name])
  end
end
