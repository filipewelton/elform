defmodule Elform.Validations.Generics.Required do
  alias Elform.SchemaFieldError

  def required(%SchemaFieldError{} = value), do: value

  def required(value) when is_nil(value) do
    %SchemaFieldError{
      arguments: [],
      reason: "a value is required",
      value: value
    }
  end

  def required(value), do: value
end
