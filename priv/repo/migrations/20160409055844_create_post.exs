defmodule LocIm.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :status, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :location, :geography

      timestamps
    end
    create index(:posts, [:user_id])

  end
end
