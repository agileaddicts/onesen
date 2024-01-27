defmodule Onesen.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :identifier, :uuid
      add :email, :string

      timestamps(type: :utc_datetime)
    end

    alter table(:notebooks) do
      add :user_id, references(:users)
    end

    create unique_index(:users, [:identifier])
    create unique_index(:users, [:email])
  end
end
