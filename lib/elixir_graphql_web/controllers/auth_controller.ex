defmodule ElixirGraphqlWeb.AuthController do
  use ElixirGraphqlWeb, :controller

  alias ElixirGraphql.Auth
  alias ElixirGraphql.Auth.User
  alias ElixirGraphqlWeb.Utils
  alias ElixirGraphqlWeb.Constants
  @bad_request 400

  def register(conn, params) do
    case Auth.create_user(params) do
      {:ok, _user} ->
        render(conn, "acknowledge.json", %{
          message: "User Registered successfully!"
        })

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(@bad_request)
        |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})

      _ ->
        conn
        |> put_status(@bad_request)
        |> render("error.json", %{
          message: Constants.internal_server_error()
        })
    end
  end

  def login(conn, params) do
    with %Ecto.Changeset{valid?: true, changes: %{username: username, password: password}} <-
           Auth.log_in(params),
         %User{} = user <- Auth.get_by_username(username),
         true <- Argon2.verify_pass(password, user.password) do
      render(conn, "acknowledge.json", %{message: "Login Successfully!"})
    else
      %Ecto.Changeset{} = changeset ->
        conn
        |> put_status(@bad_request)
        |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})

      _ ->
        conn
        |> put_status(@bad_request)
        |> render("error.json", %{
          message: Constants.invalid_credentials()
        })
    end
  end
end
