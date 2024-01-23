defmodule Elform.Validations.Strings.LengthLessThan do
  alias Elform.SchemaFieldError

  def length_less_than(%SchemaFieldError{} = value, _required_length), do: value

  def length_less_than(value, required_length) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [required_length],
      reason: "the value must be a string",
      value: value
    }
  end

  def length_less_than(value, required_length) when not is_number(required_length) do
    %SchemaFieldError{
      arguments: [required_length],
      reason: "the function has an invalid argument",
      value: value
    }
  end

  def length_less_than(value, required_length) do
    value_length = String.length(value)

    if value_length < required_length do
      value
    else
      %SchemaFieldError{
        arguments: [required_length],
        reason: "the value must be less than #{required_length}",
        value: value
      }
    end
  end
end
