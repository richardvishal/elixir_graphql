defmodule ElixirGraphqlWeb.Plugs.ProtectGraphql do
  alias ElixirGraphqlWeb.Constants
  alias ElixirGraphql.Auth
  alias ElixirGraphql.Auth.User
  import Plug.Conn

  def init(_params), do: :ok

  def call(conn, _params) do
    with user_id when not is_nil(user_id) <- Plug.Conn.get_session(conn, :current_user_id),
         %User{} = user <- Auth.get_user!(user_id) do
      conn
      |> Absinthe.Plug.put_options(context: %{current_user: user})
    else
      _ ->
        conn
        |> send_resp(401, Constants.not_authenticated())
        |> halt()
    end
  end
end
