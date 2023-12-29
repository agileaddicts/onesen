defmodule Onesen.Models.Page do
  use Ecto.Schema
  import Ecto.Changeset

  alias Onesen.Models.Notebook
  alias Onesen.Models.Page
  alias Onesen.Repo

  schema "pages" do
    field :identifier, Ecto.UUID
    field :date, :date
    field :content, :string

    belongs_to :notebook, Notebook

    timestamps(type: :utc_datetime)
  end

  def get!(identifier) do
    Repo.get_by!(Page, identifier: identifier)
  end

  def create!(notebook) do
    %Page{}
    |> changeset(%{
      identifier: Ecto.UUID.generate(),
      date: Date.utc_today(),
      content: ""
    })
    |> put_assoc(:notebook, notebook)
    |> Repo.insert!()
  end

  @doc false
  defp changeset(page, attrs) do
    page
    |> cast(attrs, [:identifier, :date, :content])
    |> validate_required([:identifier, :date])
  end
end
