defmodule ElixirGraphqlWeb.Schema.Resolvers.UserResolver do
  alias ElixirGraphql.Auth
  alias ElixirGraphqlWeb.Utils

  def register_user(_, %{input: input}, _) do
    case Auth.create_user(input) do
      {:ok, _user} ->
        {:ok, true}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.format_changeset_errors(changeset)}
    end
  end
end
