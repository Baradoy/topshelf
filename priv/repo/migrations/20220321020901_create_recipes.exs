defmodule Topshelf.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :image_url, :string
      add :directions, :text

      timestamps()
    end
  end
end
