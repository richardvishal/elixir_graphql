defmodule ElixirGraphql.ChatTest do
  use ElixirGraphql.DataCase

  alias ElixirGraphql.Chat

  describe "rooms" do
    alias ElixirGraphql.Chat.Room

    import ElixirGraphql.ChatFixtures

    @invalid_attrs %{name: nil, desripiton: nil}

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Chat.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Chat.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      valid_attrs = %{name: "some name", desripiton: "some desripiton"}

      assert {:ok, %Room{} = room} = Chat.create_room(valid_attrs)
      assert room.name == "some name"
      assert room.desripiton == "some desripiton"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      update_attrs = %{name: "some updated name", desripiton: "some updated desripiton"}

      assert {:ok, %Room{} = room} = Chat.update_room(room, update_attrs)
      assert room.name == "some updated name"
      assert room.desripiton == "some updated desripiton"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_room(room, @invalid_attrs)
      assert room == Chat.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Chat.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Chat.change_room(room)
    end
  end
end
