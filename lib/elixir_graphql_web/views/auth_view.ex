defmodule ElixirGraphqlWeb.AuthView do
  use ElixirGraphqlWeb, :view

  def render("acknowledge.json", %{message: message}) do
    %{success: true, message: message}
  end

  def render("errors.json", %{errors: errors}) do
    %{success: false, errors: errors}
  end

  def render("error.json", %{message: message}) do
    %{success: false, message: message}
  end

  def render("get_me.json", %{current_user: current_user}) do
    %{
      success: true,
      data: %{
        username: current_user.username,
        name: current_user.name,
        id: current_user.id,
        inserted_at: current_user.inserted_at,
        email: current_user.email
      }
    }
  end
end
