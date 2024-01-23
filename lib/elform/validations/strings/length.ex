defmodule Elform.Validations.Strings.Length do
  alias Elform.SchemaFieldError

  def length(%SchemaFieldError{} = value, _min, _max), do: value

  def length(value, min, max) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [min, max],
      reason: "the value must be a string",
      value: value
    }
  end

  def length(value, min, max) when not is_number(min) or not is_number(max) do
    %SchemaFieldError{
      arguments: [min, max],
      reason: "the function has one or more invalid arguments",
      value: value
    }
  end

  def length(value, min, max) do
    value_length = String.length(value)

    if value_length > min and value_length < max do
      value
    else
      %SchemaFieldError{
        arguments: [min, max],
        reason: "the value must be greater than #{min} and less than #{max}",
        value: value
      }
    end
  end
end
