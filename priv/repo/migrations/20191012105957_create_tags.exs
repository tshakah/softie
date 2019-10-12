defmodule Softie.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :scope, :string
      add :name, :string

      timestamps()
    end

  end
end
