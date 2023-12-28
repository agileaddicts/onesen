defmodule Onesen.Repo.Migrations.CreateNotebooks do
  use Ecto.Migration

  def change do
    create table(:notebooks) do
      add :identifier, :uuid

      timestamps(type: :utc_datetime)
    end
  end
end
