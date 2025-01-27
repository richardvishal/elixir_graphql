defmodule ElixirGraphqlWeb.Schema do
  use Absinthe.Schema
  import_types(ElixirGraphqlWeb.Schema.Types)
  alias ElixirGraphqlWeb.Schema.Resolvers

  query do
    @desc "greet"

    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "World"} end)
    end
  end

  mutation do
    field :register_user, :boolean do
      arg(:input, non_null(:registration_input_type))
      resolve(&Resolvers. UserResolver.register_user/3)
    end
  end
end
