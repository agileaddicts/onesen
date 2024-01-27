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
    Notebook
    |> Repo.get_by!(identifier: identifier)
    |> Repo.preload(:user)
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

  def update_user!(%{user_id: nil} = notebook, user) do
    notebook
    |> Repo.preload(:user)
    |> changeset(%{})
    |> put_assoc(:user, user)
    |> Repo.update!()
  end

  def update_user!(_notebook, _user) do
    raise Ecto.ChangeError, message: "Cannot update user for a notebook"
  end

  @doc false
  defp changeset(notebook, attrs) do
    notebook
    |> cast(attrs, [:identifier, :name])
    |> validate_required([:identifier])
    |> unique_constraint(:identifier)
  end
end
