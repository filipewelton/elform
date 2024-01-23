defmodule Elform.Validations.Strings.Email do
  alias Elform.SchemaFieldError

  def email(%SchemaFieldError{} = value), do: value

  def email(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [],
      reason: "the value must be a string",
      value: value
    }
  end

  def email(value) do
    regex = ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [],
        reason: "the value is not a valid email",
        value: value
      }
    end
  end
end
