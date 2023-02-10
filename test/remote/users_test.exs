defmodule Remote.UsersTest do
  use Remote.DataCase

  alias Remote.Users
  alias Remote.Users.User

  import Remote.UsersFixtures

  describe "user" do
    @invalid_attrs %{points: nil}

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{points: 42}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.points == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "get_users_with_min_number/1 returns users with points greater than min_number" do
      user_fixture(points: 42)
      user_fixture(points: 43)

      assert [%User{points: 43}] = Users.get_users_with_min_number(42)
    end
  end
end
