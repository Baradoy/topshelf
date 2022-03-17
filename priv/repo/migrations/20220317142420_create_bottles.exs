defmodule Topshelf.Repo.Migrations.CreateBottles do
  use Ecto.Migration

  def change do
    create table(:bottles) do
      add :brand, :string
      add :name, :string
      add :type, :string
      add :description, :text
      add :volume, :string
      add :abv, :float
      add :url, :string
      add :shelf_id, references(:shelves, on_delete: :nothing)

      timestamps()
    end

    create index(:bottles, [:shelf_id])
  end
end
