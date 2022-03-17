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
end
