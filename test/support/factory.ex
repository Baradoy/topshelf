defmodule Topshelf.Factory do
  use ExMachina.Ecto, repo: Topshelf.Repo

  def shelf_factory do
    %Topshelf.Inventory.Shelf{
      name: "some name",
      description: "some description"
    }
  end

  def bottle_factory do
    %Topshelf.Inventory.Bottle{
      abv: 120.5,
      brand: "some brand",
      description: "some description",
      name: "some name",
      type: "some type",
      image_url: "https://example.com/image",
      volume: "750ml",
      shelf: build(:shelf)
    }
  end

  def recipe_factory do
    %Topshelf.Cocktails.Recipe{
      directions: "some directions",
      image_url: "https://example.com/image",
      name: "some name"
    }
  end

  def ingredient_factory do
    %Topshelf.Cocktails.Ingredient{
      volume: "1oz",
      recipe: build(:recipe),
      bottle: build(:bottle)
    }
  end
end
