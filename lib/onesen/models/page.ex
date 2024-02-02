defmodule Onesen.Models.Page do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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

  def get_today(%Notebook{} = notebook) do
    Repo.get_by(Page, notebook_id: notebook.id, date: Date.utc_today())
  end

  def get_random_not_today(%Notebook{} = notebook) do
    query =
      from p in Page,
        where: p.notebook_id == ^notebook.id and p.date != ^Date.utc_today(),
        order_by: fragment("RANDOM()"),
        limit: 1

    Repo.one(query)
  end

  def create!(%Notebook{} = notebook) do
    %Page{}
    |> changeset(%{
      identifier: Ecto.UUID.generate(),
      date: Date.utc_today(),
      content: ""
    })
    |> put_assoc(:notebook, notebook)
    |> Repo.insert!()
  end

  def update_content!(%Page{} = page, content) do
    page
    |> changeset(%{content: String.trim(content)})
    |> Repo.update!()
  end

  @doc false
  defp changeset(%Page{} = page, attrs) do
    page
    |> cast(attrs, [:identifier, :date, :content])
    |> validate_required([:identifier, :date])
    |> unique_constraint(:identifier)
    |> unique_constraint([:date, :notebook_id])
  end
end
