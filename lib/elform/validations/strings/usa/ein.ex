defmodule Elform.Validations.Strings.Usa.Ein do
  alias Elform.SchemaFieldError

  def usa_ein(%SchemaFieldError{} = value), do: value

  def usa_ein(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [],
      reason: "the value must be a string",
      value: value
    }
  end

  def usa_ein(value) do
    regex = ~r/^(\d{2}\-\d{7})$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [],
        reason: "the value is not a valid EIN",
        value: value
      }
    end
  end
end
