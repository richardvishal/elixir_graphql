defmodule ElixirGraphqlWeb.Schema.Resolvers.UserResolver do
  alias ElixirGraphql.Auth
  alias ElixirGraphqlWeb.Utils
  alias ElixirGraphqlWeb.Constants

  def get_all_users(_, _, _) do
    {:ok, Auth.list_users()}
  end

  def register_user(_, %{input: input}, _) do
    case Auth.create_user(input) do
      {:ok, _user} ->
        {:ok, true}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.format_changeset_errors(changeset)}

      _ ->
        {:error, Constants.internal_server_error()}
    end
  end
end
