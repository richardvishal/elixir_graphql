defmodule ElixirGraphqlWeb.Plugs.PopulateAuth do
  alias ElixirGraphql.Auth
  alias ElixirGraphql.Auth.User
  import Plug.Conn

  def init(_params), do: :ok

  def call(conn, _params) do
    with user_id when not is_nil(user_id) <- Plug.Conn.get_session(conn, :current_user_id),
         %User{} = user <- Auth.get_user!(user_id) do
      conn
      |> assign(:user_assigned?, true)
      |> assign(:current_user, user)
    else
      _ ->
        conn
        |> assign(:user_assigned?, false)
        |> assign(:current_user, nil)
    end
  end
end
