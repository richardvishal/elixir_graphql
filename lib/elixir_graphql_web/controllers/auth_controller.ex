defmodule ElixirGraphqlWeb.AuthController do
  use ElixirGraphqlWeb, :controller

  alias ElixirGraphql.Auth
  alias ElixirGraphql.Auth.User
  alias ElixirGraphqlWeb.Utils
  alias ElixirGraphqlWeb.Constants
  plug :dont_exploit_me when action in [:login]
  plug :protect_me when action in [:logout]

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
      conn
      |> put_status(:created)
      |> put_session(:current_user_id, user.id)
      |> render("acknowledge.json", %{message: "Login Successfully!"})
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

  def logout(conn, _params) do
    conn
    |> Plug.Conn.clear_session()
    |> render("acknowledge.json", %{message: "Logged Out!"})
  end

  defp dont_exploit_me(conn, _params) do
    if conn.assigns.user_assigned? do
      conn |> send_resp(401, Constants.not_authorized()) |> halt
    else
      conn
    end
  end

  defp protect_me(conn, _params) do
    if conn.assigns.user_assigned? do
      conn
    else
      conn |> send_resp(401, Constants.not_authenticated()) |> halt
    end
  end
end
