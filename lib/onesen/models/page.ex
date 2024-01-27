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

  def get_today(notebook) do
    Repo.get_by(Page, notebook_id: notebook.id, date: Date.utc_today())
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

  def update_content!(page, content) do
    page
    |> changeset(%{content: String.trim(content)})
    |> Repo.update!()
  end

  @doc false
  defp changeset(page, attrs) do
    page
    |> cast(attrs, [:identifier, :date, :content])
    |> validate_required([:identifier, :date])
    |> unique_constraint(:identifier)
    |> unique_constraint([:date, :notebook_id])
  end
end
