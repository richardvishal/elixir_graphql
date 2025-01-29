defmodule ElixirGraphqlWeb.Schema.Types do
  use Absinthe.Schema.Notation
  import_types(ElixirGraphqlWeb.Schema.Types.UserType)
  import_types(ElixirGraphqlWeb.Schema.Types.RoomType)
end
