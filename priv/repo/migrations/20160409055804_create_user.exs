defmodule LocIm.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :full_name, :string
      add :avatar, :string
      add :cover, :string
      add :last_sync, :timestamp
      add :location, :geometry

      timestamps
    end

  end
end
