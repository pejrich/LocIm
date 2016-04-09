defmodule LocIm.Repo.Migrations.AddFieldsToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :image, :string
      add :category, :string
      add :reaction, :boolean
    end
  end
end
