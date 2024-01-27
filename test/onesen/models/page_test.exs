defmodule Onesen.Test.Models.PageTest do
  use Onesen.DataCase

  alias Onesen.Models.Notebook
  alias Onesen.Models.Page

  describe "get!/1" do
    test "returns page" do
      notebook = Notebook.create!()
      page = Page.create!(notebook)
      loaded_page = Page.get!(page.identifier)

      assert page.id == loaded_page.id
    end
  end

  describe "get_today/1" do
    test "returns todays page page" do
      notebook = Notebook.create!()
      page = Page.create!(notebook)
      loaded_page = Page.get_today(notebook)

      assert page.id == loaded_page.id
      assert page.date == Date.utc_today()
    end

    test "throws if page does not exist" do
      notebook = Notebook.create!()

      assert(Page.get_today(notebook) == nil)
    end
  end

  describe "create!/1" do
    test "inserts new page into notebook" do
      notebook = Notebook.create!()

      assert %Page{} = Page.create!(notebook)
    end

    test "fails if notebook already has a page for today" do
      notebook = Notebook.create!()

      Page.create!(notebook)

      assert_raise Ecto.InvalidChangesetError, fn ->
        Page.create!(notebook)
      end
    end
  end

  describe "update_content!/1" do
    test "updates content for page" do
      notebook = Notebook.create!()
      page = Page.create!(notebook)

      Page.update_content!(page, "Lorem ipsum")

      loaded_page = Page.get!(page.identifier)

      assert loaded_page.content == "Lorem ipsum"
    end

    test "updates content and trims it for page" do
      notebook = Notebook.create!()
      page = Page.create!(notebook)

      Page.update_content!(page, "   Lorem ipsum   ")

      loaded_page = Page.get!(page.identifier)

      assert loaded_page.content == "Lorem ipsum"
    end
  end
end
