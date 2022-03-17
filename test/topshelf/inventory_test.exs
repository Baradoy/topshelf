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
end
