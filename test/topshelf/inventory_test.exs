defmodule Topshelf.InventoryTest do
  use Topshelf.DataCase

  alias Topshelf.Inventory

  describe "shelves" do
    alias Topshelf.Inventory.Shelf

    import Topshelf.InventoryFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_shelves/0 returns all shelves" do
      shelf = shelf_fixture()
      assert Inventory.list_shelves() == [shelf]
    end

    test "get_shelf!/1 returns the shelf with given id" do
      shelf = shelf_fixture()
      assert Inventory.get_shelf!(shelf.id) == shelf
    end

    test "create_shelf/1 with valid data creates a shelf" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Shelf{} = shelf} = Inventory.create_shelf(valid_attrs)
      assert shelf.description == "some description"
      assert shelf.name == "some name"
    end

    test "create_shelf/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_shelf(@invalid_attrs)
    end

    test "update_shelf/2 with valid data updates the shelf" do
      shelf = shelf_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Shelf{} = shelf} = Inventory.update_shelf(shelf, update_attrs)
      assert shelf.description == "some updated description"
      assert shelf.name == "some updated name"
    end

    test "update_shelf/2 with invalid data returns error changeset" do
      shelf = shelf_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_shelf(shelf, @invalid_attrs)
      assert shelf == Inventory.get_shelf!(shelf.id)
    end

    test "delete_shelf/1 deletes the shelf" do
      shelf = shelf_fixture()
      assert {:ok, %Shelf{}} = Inventory.delete_shelf(shelf)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_shelf!(shelf.id) end
    end

    test "change_shelf/1 returns a shelf changeset" do
      shelf = shelf_fixture()
      assert %Ecto.Changeset{} = Inventory.change_shelf(shelf)
    end
  end

  describe "bottles" do
    alias Topshelf.Inventory.Bottle

    import Topshelf.InventoryFixtures

    @invalid_attrs %{abv: nil, brand: nil, description: nil, name: nil, type: nil, url: nil, volume: nil}

    test "list_bottles/0 returns all bottles" do
      bottle = bottle_fixture()
      assert Inventory.list_bottles() == [bottle]
    end

    test "get_bottle!/1 returns the bottle with given id" do
      bottle = bottle_fixture()
      assert Inventory.get_bottle!(bottle.id) == bottle
    end

    test "create_bottle/1 with valid data creates a bottle" do
      valid_attrs = %{abv: 120.5, brand: "some brand", description: "some description", name: "some name", type: "some type", url: "some url", volume: "some volume"}

      assert {:ok, %Bottle{} = bottle} = Inventory.create_bottle(valid_attrs)
      assert bottle.abv == 120.5
      assert bottle.brand == "some brand"
      assert bottle.description == "some description"
      assert bottle.name == "some name"
      assert bottle.type == "some type"
      assert bottle.url == "some url"
      assert bottle.volume == "some volume"
    end

    test "create_bottle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_bottle(@invalid_attrs)
    end

    test "update_bottle/2 with valid data updates the bottle" do
      bottle = bottle_fixture()
      update_attrs = %{abv: 456.7, brand: "some updated brand", description: "some updated description", name: "some updated name", type: "some updated type", url: "some updated url", volume: "some updated volume"}

      assert {:ok, %Bottle{} = bottle} = Inventory.update_bottle(bottle, update_attrs)
      assert bottle.abv == 456.7
      assert bottle.brand == "some updated brand"
      assert bottle.description == "some updated description"
      assert bottle.name == "some updated name"
      assert bottle.type == "some updated type"
      assert bottle.url == "some updated url"
      assert bottle.volume == "some updated volume"
    end

    test "update_bottle/2 with invalid data returns error changeset" do
      bottle = bottle_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_bottle(bottle, @invalid_attrs)
      assert bottle == Inventory.get_bottle!(bottle.id)
    end

    test "delete_bottle/1 deletes the bottle" do
      bottle = bottle_fixture()
      assert {:ok, %Bottle{}} = Inventory.delete_bottle(bottle)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_bottle!(bottle.id) end
    end

    test "change_bottle/1 returns a bottle changeset" do
      bottle = bottle_fixture()
      assert %Ecto.Changeset{} = Inventory.change_bottle(bottle)
    end
  end
end
