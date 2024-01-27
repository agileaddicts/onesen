defmodule Onesen.Models.Notebook do
  use Ecto.Schema
  import Ecto.Changeset

  alias Onesen.Models.Notebook
  alias Onesen.Models.Page
  alias Onesen.Models.User
  alias Onesen.Repo

  schema "notebooks" do
    field :identifier, Ecto.UUID
    field :name, :string

    belongs_to :user, User

    has_many :pages, Page

    timestamps(type: :utc_datetime)
  end

  def get!(identifier) do
    Repo.get_by!(Notebook, identifier: identifier)
  end

  def create! do
    %Notebook{}
    |> changeset(%{identifier: Ecto.UUID.generate()})
    |> Repo.insert!()
  end

  def update_name!(notebook, name) do
    notebook
    |> changeset(%{name: name})
    |> Repo.update!()
  end

  @doc false
  defp changeset(notebook, attrs) do
    notebook
    |> cast(attrs, [:identifier, :name])
    |> validate_required([:identifier])
    |> unique_constraint(:identifier)
  end
end
