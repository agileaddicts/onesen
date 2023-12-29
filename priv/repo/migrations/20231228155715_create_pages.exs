defmodule Onesen.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :identifier, :uuid
      add :date, :date
      add :content, :text

      add :notebook_id, references(:notebooks)

      timestamps(type: :utc_datetime)
    end
  end
end
