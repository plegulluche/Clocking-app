defmodule Api.DirectoryTest do
  use Api.DataCase

  alias Api.Directory

  describe "users" do
    alias Api.Directory.User

    import Api.DirectoryFixtures

    @invalid_attrs %{email: nil, username: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Directory.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Directory.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{email: "some email", username: "some username"}

      assert {:ok, %User{} = user} = Directory.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{email: "some updated email", username: "some updated username"}

      assert {:ok, %User{} = user} = Directory.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_user(user, @invalid_attrs)
      assert user == Directory.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Directory.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Directory.change_user(user)
    end
  end

  describe "clocks" do
    alias Api.Directory.Clock

    import Api.DirectoryFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Directory.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Directory.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~N[2022-10-24 14:32:00]}

      assert {:ok, %Clock{} = clock} = Directory.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~N[2022-10-24 14:32:00]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~N[2022-10-25 14:32:00]}

      assert {:ok, %Clock{} = clock} = Directory.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~N[2022-10-25 14:32:00]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_clock(clock, @invalid_attrs)
      assert clock == Directory.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Directory.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Directory.change_clock(clock)
    end
  end
end
