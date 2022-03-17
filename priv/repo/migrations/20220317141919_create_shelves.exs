defmodule Topshelf.Repo.Migrations.CreateShelves do
  use Ecto.Migration

  def change do
    create table(:shelves) do
      add :name, :string
      add :description, :text

      timestamps()
    end
  end
end
