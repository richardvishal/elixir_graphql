# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ElixirGraphql.Repo.insert!(%ElixirGraphql.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# priv/repo/seeds.exs
# priv/repo/seeds.exs

alias ElixirGraphql.Repo
alias ElixirGraphql.Auth.User
alias ElixirGraphql.Chat.Room
alias ElixirGraphql.Chat.Message.Message

# Create 5 users, and for each user, create 5 rooms, and for each room, create 5 messages
Enum.each(1..5, fn _ ->
  user_attrs = %{
    name: Faker.Person.name(),
    email: Faker.Internet.email(),
    username: Faker.Internet.user_name(),
    password: "password123"
  }

  case Repo.insert(User.changeset(%User{}, user_attrs)) do
    {:ok, user} ->
      IO.puts("Created user #{user.username}")

      # Create 5 rooms for each user
      Enum.each(1..5, fn _ ->
        # Generate a valid room name (at least 5 characters)
        room_name =
          Faker.Lorem.word()
          |> then(fn name -> if String.length(name) < 5, do: name <> Faker.Lorem.word(), else: name end)
          |> String.capitalize()

        room_attrs = %{
          name: room_name,
          description: Faker.Lorem.sentence(),
          user_id: user.id
        }

        case Repo.insert(Room.changeset(%Room{}, room_attrs)) do
          {:ok, room} ->
            IO.puts("  Created room #{room.name} for user #{user.username}")

            # Create 5 messages for each room
            Enum.each(1..5, fn _ ->
              message_attrs = %{
                content: Faker.Lorem.sentence(),
                user_id: user.id,
                room_id: room.id
              }

              case Repo.insert(Message.changeset(%Message{}, message_attrs)) do
                {:ok, _message} ->
                  IO.puts("    Created message in room #{room.name}")
                {:error, changeset} ->
                  IO.puts("    Failed to create message: #{inspect(changeset)}")
              end
            end)

          {:error, changeset} ->
            IO.puts("  Failed to create room: #{inspect(changeset)}")
        end
      end)

    {:error, changeset} ->
      IO.puts("Failed to create user: #{inspect(changeset)}")
  end
end)

IO.puts("Seeding complete!")
