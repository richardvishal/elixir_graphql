defmodule ElixirGraphql.Chat.Message.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirGraphql.Auth.User
  alias ElixirGraphql.Chat.Room

  schema "messages" do
    field :content, :string
    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :user_id, :room_id])
    |> validate_required([:content, :user_id, :room_id])
  end
end
