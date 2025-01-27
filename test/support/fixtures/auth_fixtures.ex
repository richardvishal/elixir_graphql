defmodule ElixirGraphql.AuthFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirGraphql.Auth` context.
  """

  @doc """
  Generate a unique user username.
  """
  def unique_user_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name",
        username: unique_user_username(),
        password: "some password",
        email: unique_user_email()
      })
      |> ElixirGraphql.Auth.create_user()

    user
  end
end
