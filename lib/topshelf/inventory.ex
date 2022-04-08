defmodule Topshelf.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Topshelf.Repo

  alias Topshelf.Inventory.Shelf
  alias Topshelf.Measurements

  @doc """
  Returns the list of shelves.

  ## Examples

      iex> list_shelves()
      [%Shelf{}, ...]

  """
  def list_shelves do
    Shelf
    |> order_by(desc: :updated_at)
    |> Repo.all()
  end

  @doc """
  Gets a single shelf.

  Raises `Ecto.NoResultsError` if the Shelf does not exist.

  ## Examples

      iex> get_shelf!(123)
      %Shelf{}

      iex> get_shelf!(456)
      ** (Ecto.NoResultsError)

  """
  def get_shelf!(id), do: Repo.get!(Shelf, id)

  @doc """
  Creates a shelf.

  ## Examples

      iex> create_shelf(%{field: value})
      {:ok, %Shelf{}}

      iex> create_shelf(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_shelf(attrs \\ %{}) do
    %Shelf{}
    |> Shelf.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shelf.

  ## Examples

      iex> update_shelf(shelf, %{field: new_value})
      {:ok, %Shelf{}}

      iex> update_shelf(shelf, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_shelf(%Shelf{} = shelf, attrs) do
    shelf
    |> Shelf.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a shelf.

  ## Examples

      iex> delete_shelf(shelf)
      {:ok, %Shelf{}}

      iex> delete_shelf(shelf)
      {:error, %Ecto.Changeset{}}

  """
  def delete_shelf(%Shelf{} = shelf) do
    Repo.delete(shelf)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shelf changes.

  ## Examples

      iex> change_shelf(shelf)
      %Ecto.Changeset{data: %Shelf{}}

  """
  def change_shelf(%Shelf{} = shelf, attrs \\ %{}) do
    Shelf.changeset(shelf, attrs)
  end

  alias Topshelf.Inventory.Bottle

  @doc """
  Returns the list of bottles matching the search query

  ## Examples

      iex> list_bottles()
      [%Bottle{}, ...]

  """
  def list_bottles(opts \\ []) do
    opts
    |> Enum.reduce(Bottle, fn
      {:search, search}, query ->
        s = "%#{search}%"
        query |> where([b], like(b.brand, ^s) or like(b.name, ^s) or like(b.type, ^s))

      {:percent, percent}, query ->
        query |> where([b], b.remaining_percent <= ^percent)
    end)
    |> preload(:shelf)
    |> order_by(desc: :updated_at)
    |> Repo.all()
  end

  @doc """
  Gets a single bottle.

  Raises `Ecto.NoResultsError` if the Bottle does not exist.

  ## Examples

      iex> get_bottle!(123)
      %Bottle{}

      iex> get_bottle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bottle!(id) do
    Bottle
    |> preload(:shelf)
    |> Repo.get!(id)
  end

  @doc """
  Creates a bottle.

  ## Examples

      iex> create_bottle(%{field: value})
      {:ok, %Bottle{}}

      iex> create_bottle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bottle(attrs \\ %{}) do
    %Bottle{}
    |> Bottle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bottle.

  ## Examples

      iex> update_bottle(bottle, %{field: new_value})
      {:ok, %Bottle{}}

      iex> update_bottle(bottle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bottle(%Bottle{} = bottle, attrs) do
    bottle
    |> Bottle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bottle.

  ## Examples

      iex> delete_bottle(bottle)
      {:ok, %Bottle{}}

      iex> delete_bottle(bottle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bottle(%Bottle{} = bottle) do
    Repo.delete(bottle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bottle changes.

  ## Examples

      iex> change_bottle(bottle)
      %Ecto.Changeset{data: %Bottle{}}

  """
  def change_bottle(%Bottle{} = bottle, attrs \\ %{}) do
    Bottle.changeset(bottle, attrs)
  end

  @doc """
  A changeset for a pour of a bottle

  ## Examples

      iex> pour_bottle_changeset(bottle)
      %Ecto.Changeset{data: %Bottle{}, changes: %{remaining_percent: ...}}

  """
  def pour_bottle_changeset(%Bottle{} = bottle, {amount, unit}) do
    volume = Measurements.to_measure(bottle.volume)

    remaining_percent =
      volume
      |> Measurements.percent_of_measure(bottle.remaining_percent / 100.0)
      |> Measurements.pour({amount, unit})
      |> Measurements.measure_to_percent(volume)

    Bottle.changeset(bottle, %{remaining_percent: trunc(remaining_percent * 100)})
  end
end
