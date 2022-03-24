defmodule Topshelf.Cocktails do
  @moduledoc """
  The Cocktails context.
  """

  import Ecto.Query, warn: false
  alias Topshelf.Repo

  alias Topshelf.Cocktails.Recipe

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    Recipe
    |> preload(ingredients: [:bottle])
    |> Repo.all()
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id) do
    Recipe
    |> preload(ingredients: [:bottle])
    |> Repo.get!(id)
  end

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> recipe_changeset(recipe)
      %Ecto.Changeset{data: %Recipe{}}

  """
  def recipe_changeset(%Recipe{} = recipe, attrs \\ %{}) do
    Recipe.changeset(recipe, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` with a fresh ingredient

  ## Examples

      iex> recipe_add_ingredient_changeset(recipe)
      %Ecto.Changeset{data: %Recipe{}}

  """
  def recipe_add_ingredient_changeset(%Ecto.Changeset{} = changeset)
      when is_struct(changeset.data, Recipe) do
    {_, ingredients} = Ecto.Changeset.fetch_field(changeset, :ingredients)

    Ecto.Changeset.put_assoc(changeset, :ingredients, ingredients ++ [%{volume: "1oz"}])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` with an ingredient removed at index

  ## Examples

      iex> recipe_remove_ingredient_changeset(recipe, index)
      %Ecto.Changeset{data: %Recipe{}}

  """
  def recipe_remove_ingredient_changeset(%Ecto.Changeset{} = changeset, index)
      when is_struct(changeset.data, Recipe) do
    {_, ingredients} = Ecto.Changeset.fetch_field(changeset, :ingredients)

    Ecto.Changeset.put_assoc(changeset, :ingredients, List.delete_at(ingredients, index))
  end

  alias Topshelf.Cocktails.Ingredient

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients do
    Ingredient
    |> preload([:recipe, bottle: [:shelf]])
    |> Repo.all()
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient!(id) do
    Ingredient
    |> preload([:recipe, bottle: [:shelf]])
    |> Repo.get!(id)
  end

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient) do
    Repo.delete(ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{data: %Ingredient{}}

  """
  def change_ingredient(%Ingredient{} = ingredient, attrs \\ %{}) do
    Ingredient.changeset(ingredient, attrs)
  end
end
