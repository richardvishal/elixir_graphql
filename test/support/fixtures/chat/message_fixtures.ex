defmodule ElixirGraphql.Chat.MessageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirGraphql.Chat.Message` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> ElixirGraphql.Chat.Message.create_message()

    message
  end
end
