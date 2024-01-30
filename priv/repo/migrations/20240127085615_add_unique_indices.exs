defmodule Onesen.Repo.Migrations.AddUniqueIndices do
  use Ecto.Migration

  def change do
    create unique_index(:notebooks, [:identifier])

    create unique_index(:pages, [:identifier])
    create unique_index(:pages, [:date, :notebook_id])
  end
end
