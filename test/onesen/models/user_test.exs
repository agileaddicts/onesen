defmodule Onesen.Test.Models.UserTest do
  use Onesen.DataCase

  alias Onesen.Models.User

  describe "create!/1" do
    test "inserts new user" do
      assert %User{} = User.create!("nobody@onesen.localhost")
    end

    test "fails if email is already taken" do
      User.create!("nobody@onesen.localhost")

      assert_raise Ecto.InvalidChangesetError, fn ->
        User.create!("nobody@onesen.localhost")
      end
    end
  end
end
