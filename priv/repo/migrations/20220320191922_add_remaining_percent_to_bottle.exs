defmodule Topshelf.Repo.Migrations.AddRemainingPercentToBottle do
  use Ecto.Migration

  def change do
    alter table("bottles") do
      add :remaining_percent, :integer
    end

    rename table("bottles"), :url, to: :image_url
  end
end
