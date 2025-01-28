defmodule ElixirGraphqlWeb.Schema do
  use Absinthe.Schema
  import_types(ElixirGraphqlWeb.Schema.Types)
  alias ElixirGraphqlWeb.Schema.Resolvers

  query do
    @desc "greet"

    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "World"} end)
    end

    @desc "Get all users"
    field :users, list_of(:user_type) do
      resolve(&Resolvers.UserResolver.get_all_users/3)
    end
  end
end
