defmodule Topshelf.Factory do
  use ExMachina.Ecto, repo: Topshelf.Repo

  def shelf_factory do
    %Topshelf.Inventory.Shelf{
      name: "some name",
      description: "some description",
    }
  end

  def bottle_factory do
    %Topshelf.Inventory.Bottle{
      abv: 120.5,
      brand: "some brand",
      description: "some description",
      name: "some name",
      type: "some type",
      url: "https://example.com/image",
      volume: "some volume",
      shelf: build(:shelf)
    }
  end

end