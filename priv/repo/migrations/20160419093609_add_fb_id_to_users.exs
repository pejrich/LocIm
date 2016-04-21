defmodule LocIm.Repo.Migrations.AddFbIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :fb_id, :string
    end
  end
end
