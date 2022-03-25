defmodule Topshelf.CocktailsTest do
  use Topshelf.DataCase

  import Topshelf.Factory

  alias Topshelf.Cocktails
  alias Topshelf.Cocktails.Recipe
  alias Topshelf.Cocktails.Ingredient

  describe "recipes" do
    @invalid_attrs %{directions: nil, image_url: nil, name: nil}

    test "list_recipes/0 returns all recipes" do
      recipe = insert(:recipe) |> preload()
      assert Cocktails.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = insert(:recipe) |> preload()
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
      recipe = insert(:recipe) |> preload()

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
      recipe = insert(:recipe) |> preload()
      assert {:error, %Ecto.Changeset{}} = Cocktails.update_recipe(recipe, @invalid_attrs)
      assert recipe == Cocktails.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = insert(:recipe)
      assert {:ok, %Recipe{}} = Cocktails.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Cocktails.get_recipe!(recipe.id) end
    end

    test "recipe_changeset/1 returns a recipe changeset" do
      recipe = insert(:recipe) |> preload()
      assert %Ecto.Changeset{} = Cocktails.recipe_changeset(recipe)
    end
  end

  describe "ingredients" do
    @invalid_attrs %{volume: nil}

    test "list_ingredients/0 returns all ingredients" do
      ingredient = insert(:ingredient) |> preload
      assert Cocktails.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = insert(:ingredient) |> preload()
      assert Cocktails.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      bottle = insert(:bottle)
      valid_attrs = %{volume: "1.5oz", bottle_id: bottle.id}

      assert {:ok, %Ingredient{} = ingredient} = Cocktails.create_ingredient(valid_attrs)
      assert ingredient.volume == "1.5oz"
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cocktails.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = insert(:ingredient)
      update_attrs = %{volume: "750ml"}

      assert {:ok, %Ingredient{} = ingredient} =
               Cocktails.update_ingredient(ingredient, update_attrs)

      assert ingredient.volume == "750ml"
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = insert(:ingredient) |> preload()
      update_attrs = %{volume: "750dallops"}

      assert {:error, %Ecto.Changeset{}} = Cocktails.update_ingredient(ingredient, update_attrs)
      assert ingredient == Cocktails.get_ingredient!(ingredient.id)
    end

    test "update_ingredient/2 with invalid unit returns error changeset" do
      ingredient = insert(:ingredient) |> preload()
      assert {:error, %Ecto.Changeset{}} = Cocktails.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Cocktails.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = insert(:ingredient) |> preload()
      assert {:ok, %Ingredient{}} = Cocktails.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Cocktails.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = insert(:ingredient) |> preload()
      assert %Ecto.Changeset{} = Cocktails.change_ingredient(ingredient)
    end
  end

  describe "Pour a Recipe" do
    test "pour_recipe/2 pours a cocktail with a single ingredient" do
      recipe =
        insert(:recipe,
          ingredients: [
            build(:ingredient,
              volume: "1oz",
              bottle: build(:bottle, volume: "100oz", remaining_percent: 100)
            )
          ]
        )
        |> preload()

      {:ok, multi} = Cocktails.pour_recipe(recipe)

      Enum.each(multi, fn {_k, bottle} ->
        assert bottle.remaining_percent == 99
      end)
    end

    test "pour_recipe/2 pours a cocktail with a multiple ingredients" do
      recipe =
        insert(:recipe,
          ingredients: [
            build(:ingredient,
              volume: "1oz",
              bottle: build(:bottle, volume: "100oz", remaining_percent: 100)
            ),
            build(:ingredient,
              volume: "1ml",
              bottle: build(:bottle, volume: "100ml", remaining_percent: 100)
            ),
            build(:ingredient,
              volume: "1oz",
              bottle: build(:bottle, volume: "2958ml", remaining_percent: 100)
            )
          ]
        )
        |> preload()

      {:ok, multi} = Cocktails.pour_recipe(recipe)

      Enum.each(multi, fn {_k, bottle} ->
        assert bottle.remaining_percent == 99
      end)
    end

    test "pour_recipe/2 pours a cocktail with an ingredient without a volume" do
      recipe =
        insert(:recipe,
          ingredients: [
            build(:ingredient,
              volume: "1.5oz",
              bottle: build(:bottle, volume: nil, remaining_percent: 100)
            )
          ]
        )
        |> preload()

      {:ok, multi} = Cocktails.pour_recipe(recipe)

      Enum.each(multi, fn {_k, bottle} ->
        assert bottle.remaining_percent == 100
      end)
    end
  end

  defp preload(%Recipe{} = recipie) do
    Repo.preload(recipie, ingredients: [:bottle])
  end

  defp preload(%Ingredient{} = recipie) do
    Repo.preload(recipie, [:recipe, bottle: [:shelf]])
  end
end
