defmodule Elform.Validations.Strings.Usa.Ssn do
  alias Elform.SchemaFieldError

  def usa_ssn(%SchemaFieldError{} = value), do: value

  def usa_ssn(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [],
      reason: "the value must be a string",
      value: value
    }
  end

  def usa_ssn(value) do
    regex = ~r/^(?!666|000|9\d{2})\d{3}-(?!00)\d{2}-(?!0{4})\d{4}$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [],
        reason: "the value is not a valid SSN",
        value: value
      }
    end
  end
end
