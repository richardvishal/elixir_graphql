defmodule ElixirGraphqlWeb.Schema.Resolvers.UserResolver do
  alias ElixirGraphql.Auth

  def get_all_users(_, _, _) do
    {:ok, Auth.list_users()}
  end

  def get_me(_, _, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end
end
