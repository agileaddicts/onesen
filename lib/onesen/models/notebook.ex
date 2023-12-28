defmodule Onesen.Models.Notebook do
  use Ecto.Schema
  import Ecto.Changeset

  alias Onesen.Models.Notebook
  alias Onesen.Repo

  schema "notebooks" do
    field :identifier, Ecto.UUID

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

  @doc false
  defp changeset(notebook, attrs) do
    notebook
    |> cast(attrs, [:identifier])
    |> validate_required([:identifier])
  end
end
