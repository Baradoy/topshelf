defmodule Topshelf.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Topshelf.Inventory` context.
  """

  @doc """
  Generate a shelf.
  """
  def shelf_fixture(attrs \\ %{}) do
    {:ok, shelf} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Topshelf.Inventory.create_shelf()

    shelf
  end

  @doc """
  Generate a bottle.
  """
  def bottle_fixture(attrs \\ %{}) do
    {:ok, bottle} =
      attrs
      |> Enum.into(%{
        abv: 120.5,
        brand: "some brand",
        description: "some description",
        name: "some name",
        type: "some type",
        url: "some url",
        volume: "some volume"
      })
      |> Topshelf.Inventory.create_bottle()

    bottle
  end
end
