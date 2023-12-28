defmodule Onesen.Test.Models.NotebookTest do
  use Onesen.DataCase

  alias Onesen.Models.Notebook

  describe "get!/1" do
    test "returns notebook" do
      notebook = Notebook.create!()
      assert notebook == Notebook.get!(notebook.identifier)
    end
  end

  describe "create!/0" do
    test "inserts new notebook" do
      assert %Notebook{} = Notebook.create!()
    end
  end
end
