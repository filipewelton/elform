defmodule Elform.Validations.Strings.Uuid do
  alias Elform.SchemaFieldError

  def uuid(%SchemaFieldError{} = value), do: value

  def uuid(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [],
      reason: "the value must be a string",
      value: value
    }
  end

  def uuid(value) do
    regex = ~r/^[0-9a-f]{8}-[0-9a-f]{4}-[0-5][0-9a-f]{3}-[089ab][0-9a-f]{3}-[0-9a-f]{12}$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [],
        reason: "the value is not a valid UUID",
        value: value
      }
    end
  end
end
