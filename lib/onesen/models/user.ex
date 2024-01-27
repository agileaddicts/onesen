defmodule Onesen.Models.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Onesen.Models.Notebook
  alias Onesen.Models.User
  alias Onesen.Repo

  schema "users" do
    field :identifier, Ecto.UUID
    field :email, :string

    has_many :notebooks, Notebook

    timestamps(type: :utc_datetime)
  end

  def create!(email) do
    %User{}
    |> changeset(%{identifier: Ecto.UUID.generate(), email: email})
    |> Repo.insert!()
  end

  @doc false
  defp changeset(user, attrs) do
    user
    |> cast(attrs, [:identifier, :email])
    |> validate_required([:identifier, :email])
    |> unique_constraint(:identifier)
    |> unique_constraint(:email)
  end
end
