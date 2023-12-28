defmodule Onesen.Test.Models.NotebookTest do
  use Onesen.DataCase

  alias Onesen.Models.Notebook

  describe "create/0" do
    test "inserts new notebook" do
      assert %Notebook{} = Notebook.create!()
    end
  end
end
