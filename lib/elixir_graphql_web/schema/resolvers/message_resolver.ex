defmodule ElixirGraphqlWeb.Schema.Resolvers.MessageResolver do
  alias ElixirGraphqlWeb.Constants
  alias ElixirGraphqlWeb.Utils
  alias ElixirGraphql.Chat.Message
  alias ElixirGraphql.Chat

  def get_all_messages(_, %{input: input}, _) do
    {:ok, Message.list_messages(input.room_id)}
  end

  def create_message(_, %{input: input}, %{context: context}) do
    with room when not is_nil(room) <- Chat.get_room(input.room_id),
         {:ok, _changeset} <-
           Message.create_message(
             Map.merge(input, %{user_id: context.current_user.id, room_id: input.room_id})
           ) do
      {:ok, true}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.format_changeset_errors(changeset)}

      nil ->
        {:error, Constants.not_found()}

      _ ->
        {:error, Constants.internal_server_error()}
    end
  end

  def delete_message(_, %{input: input}, %{context: context}) do
    case Message.delete_message_by_id(input.message_id, context.current_user.id) do
      {:ok, :deleted} -> {:ok, true}
      {:error, :not_found} -> {:error, Constants.not_found()}
      _ -> {:error, Constants.internal_server_error()}
    end
  end
end
