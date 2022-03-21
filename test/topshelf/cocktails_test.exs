defmodule Topshelf.CocktailsTest do
  use Topshelf.DataCase

  import Topshelf.Factory

  alias Topshelf.Cocktails

  describe "recipes" do
    alias Topshelf.Cocktails.Recipe

    @invalid_attrs %{directions: nil, image_url: nil, name: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = insert(:recipe)
      assert Cocktails.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = insert(:recipe)
      assert Cocktails.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      valid_attrs = %{
        directions: "some directions",
        image_url: "some image_url",
        name: "some name"
      }

      assert {:ok, %Recipe{} = recipe} = Cocktails.create_recipe(valid_attrs)
      assert recipe.directions == "some directions"
      assert recipe.image_url == "some image_url"
      assert recipe.name == "some name"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cocktails.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = insert(:recipe)

      update_attrs = %{
        directions: "some updated directions",
        image_url: "some updated image_url",
        name: "some updated name"
      }

      assert {:ok, %Recipe{} = recipe} = Cocktails.update_recipe(recipe, update_attrs)
      assert recipe.directions == "some updated directions"
      assert recipe.image_url == "some updated image_url"
      assert recipe.name == "some updated name"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = insert(:recipe)
      assert {:error, %Ecto.Changeset{}} = Cocktails.update_recipe(recipe, @invalid_attrs)
      assert recipe == Cocktails.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = insert(:recipe)
      assert {:ok, %Recipe{}} = Cocktails.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Cocktails.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = insert(:recipe)
      assert %Ecto.Changeset{} = Cocktails.change_recipe(recipe)
    end
  end

  describe "ingredients" do
    alias Topshelf.Cocktails.Ingredient

    @invalid_attrs %{volume: nil}

    test "list_ingredients/0 returns all ingredients" do
      ingredient = insert(:ingredient)
      assert Cocktails.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = insert(:ingredient)
      assert Cocktails.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      valid_attrs = %{volume: "some volume"}

      assert {:ok, %Ingredient{} = ingredient} = Cocktails.create_ingredient(valid_attrs)
      assert ingredient.volume == "some volume"
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cocktails.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = insert(:ingredient)
      update_attrs = %{volume: "some updated volume"}

      assert {:ok, %Ingredient{} = ingredient} =
               Cocktails.update_ingredient(ingredient, update_attrs)

      assert ingredient.volume == "some updated volume"
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = insert(:ingredient)
      assert {:error, %Ecto.Changeset{}} = Cocktails.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Cocktails.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = insert(:ingredient)
      assert {:ok, %Ingredient{}} = Cocktails.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Cocktails.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = insert(:ingredient)
      assert %Ecto.Changeset{} = Cocktails.change_ingredient(ingredient)
    end
  end
end
