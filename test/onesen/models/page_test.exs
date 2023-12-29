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

  describe "create!/1" do
    test "inserts new page into notebook" do
      notebook = Notebook.create!()
      assert %Page{} = Page.create!(notebook)
    end
  end
end
