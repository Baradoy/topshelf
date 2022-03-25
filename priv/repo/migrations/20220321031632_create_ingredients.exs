defmodule Topshelf.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :volume, :string
      add :recipe_id, references(:recipes, on_delete: :nothing)
      add :bottle_id, references(:bottles, on_delete: :nothing)

      timestamps()
    end

    create index(:ingredients, [:recipe_id])
    create index(:ingredients, [:bottle_id])
  end
end
