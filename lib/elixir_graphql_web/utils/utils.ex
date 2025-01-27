defmodule ElixirGraphqlWeb.Utils do
  import Ecto.Changeset

  def format_changeset_errors(%Ecto.Changeset{} = changeset) do
      traverse_errors(changeset, fn {msg, opts} ->
        Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
          opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
        end)
      end)
      |> Enum.map(fn {key, value} -> "#{key} #{value}" end)
  end
end
