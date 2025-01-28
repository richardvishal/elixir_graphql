defmodule ElixirGraphqlWeb.AuthView do
  use ElixirGraphqlWeb, :view

  def render("acknowledge.json", %{success: success, message: message}) do
    %{success: success, message: message}
  end

  def render("error.json", %{errors: errors}) do
    %{success: false, errors: errors}
  end
end
