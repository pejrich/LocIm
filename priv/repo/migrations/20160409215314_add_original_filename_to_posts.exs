defmodule LocIm.Repo.Migrations.AddOriginalFilenameToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :original_filename, :string
    end
  end
end
