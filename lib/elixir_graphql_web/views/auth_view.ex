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
end
