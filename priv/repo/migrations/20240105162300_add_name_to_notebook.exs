defmodule Onesen.Repo.Migrations.AddNameToNotebook do
  use Ecto.Migration

  def change do
    alter table(:notebooks) do
      add :name, :string
    end
  end
end
