defmodule ElixirGraphqlWeb.Schema do
  use Absinthe.Schema

  @desc "First Query"
  query do
    field :hello, :string do
      resolve(fn _, _, _ -> {:ok, "World"} end)
    end
  end
end
