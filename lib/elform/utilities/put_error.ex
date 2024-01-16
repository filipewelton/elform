defmodule Elform.Utilities.PutError do
  alias Elform.Schema

  def call(%Schema{} = schema, message) do
    errors =
      Map.get(schema, :errors, [])
      |> Keyword.merge(message)

    Map.put(schema, :errors, errors)
    |> Map.put(:valid?, false)
  end
end
