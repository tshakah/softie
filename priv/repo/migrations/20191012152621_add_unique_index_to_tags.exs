defmodule Softie.Repo.Migrations.AddUniqueIndexToTags do
  use Ecto.Migration

  def change do
    create unique_index("tags", ["(lower(scope))", "(lower(name))"], name: :unique_scoped_name)
  end
end
