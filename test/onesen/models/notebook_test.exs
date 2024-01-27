defmodule Onesen.Test.Models.NotebookTest do
  use Onesen.DataCase

  alias Onesen.Models.Notebook
  alias Onesen.Models.User

  describe "get!/1" do
    test "returns notebook" do
      notebook = Notebook.create!()
      loaded_notebook = Notebook.get!(notebook.identifier)
      assert notebook.id == loaded_notebook.id
    end
  end

  describe "create!/0" do
    test "inserts new notebook with empty name" do
      assert %Notebook{name: nil} = Notebook.create!()
    end
  end

  describe "update_name!/2" do
    test "sets a name for an unnamed notebook" do
      notebook = Notebook.create!()

      Notebook.update_name!(notebook, "Lorem ipsum")

      loaded_notebook = Notebook.get!(notebook.identifier)

      assert loaded_notebook.name == "Lorem ipsum"
    end

    test "overrites a name" do
      notebook = Notebook.create!()

      Notebook.update_name!(notebook, "Lorem ipsum")
      Notebook.update_name!(notebook, "Lorem ipsum dolor")

      loaded_notebook = Notebook.get!(notebook.identifier)

      assert loaded_notebook.name == "Lorem ipsum dolor"
    end
  end

  describe "update_user!/2" do
    test "adds a user to a notebook" do
      notebook = Notebook.create!()
      user = User.create!("nobody@onesen.localhost")

      Notebook.update_user!(notebook, user)

      loaded_notebook = Notebook.get!(notebook.identifier)

      assert loaded_notebook.user.email == "nobody@onesen.localhost"
    end

    test "does not allow changing of a user for a notebook" do
      notebook = Notebook.create!()
      user = User.create!("nobody@onesen.localhost")
      user2 = User.create!("somebodz@onesen.localhost")

      notebook = Notebook.update_user!(notebook, user)

      assert_raise Ecto.ChangeError, fn ->
        Notebook.update_user!(notebook, user2)
      end

      loaded_notebook = Notebook.get!(notebook.identifier)

      assert loaded_notebook.user.email == "nobody@onesen.localhost"
    end
  end
end
