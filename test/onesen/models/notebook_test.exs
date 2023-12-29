defmodule Onesen.Test.Models.NotebookTest do
  use Onesen.DataCase

  alias Onesen.Models.Notebook

  describe "get!/1" do
    test "returns notebook" do
      notebook = Notebook.create!()
      loaded_notebook = Notebook.get!(notebook.identifier)
      assert notebook.id == loaded_notebook.id
    end
  end

  describe "create!/0" do
    test "inserts new notebook" do
      assert %Notebook{} = Notebook.create!()
    end
  end
end
