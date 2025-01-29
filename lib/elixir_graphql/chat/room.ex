defmodule ElixirGraphql.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirGraphql.Auth.User
  alias ElixirGraphql.Chat.Message.Message

  schema "rooms" do
    field :name, :string
    field :description, :string
    belongs_to :user, User
    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :description, :user_id])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 5, max: 30)
    |> validate_length(:description, min: 10, max: 100)
  end
end
