defmodule ElixirGraphqlWeb.AuthController do
  use ElixirGraphqlWeb, :controller

  alias ElixirGraphql.Auth
  alias ElixirGraphqlWeb.Utils
  alias ElixirGraphqlWeb.Constants

  def register(conn, params) do

    case Auth.create_user(params) do
      {:ok, _user} ->
        render(conn, "acknowledge.json", %{
          success: true,
          message: "User Registered successfully!"
        })

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(400)
        |> render("error.json", %{errors: Utils.format_changeset_errors(changeset)})

      _ ->
        conn
        |> put_status(400)
        |> render("acknowledge.json", %{
          message: Constants.internal_server_error(),
          success: false
        })
    end
  end
end
