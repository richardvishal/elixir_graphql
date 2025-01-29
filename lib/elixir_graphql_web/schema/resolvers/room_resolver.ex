defmodule ElixirGraphqlWeb.Schema.Resolvers.RoomResolver do
  alias ElixirGraphqlWeb.Constants
  alias ElixirGraphqlWeb.Utils
  alias ElixirGraphql.Chat

  def get_all_rooms(_, _, _) do
    {:ok, Chat.list_rooms()}
  end

  def create_room(_, %{input: input}, %{context: context}) do
    case Chat.create_room(Map.merge(input, %{user_id: context.current_user.id})) do
      {:ok, _changeset} ->
        {:ok, true}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.format_changeset_errors(changeset)}

      _ ->
        {:error, Constants.internal_server_error()}
    end
  end

  def delete_room(_, %{input: input}, %{context: context}) do
    case Chat.delete_room_by_id(input.room_id, context.current_user.id) do
      {:ok, :deleted} -> {:ok, true}
      {:error, :not_found} -> {:error, Constants.not_found()}
      _ -> {:error, Constants.internal_server_error()}
    end
  end
end
