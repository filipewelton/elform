defmodule Elform.Validations.Strings.Bra.Cpf do
  alias Elform.SchemaFieldError

  def bra_cpf(%SchemaFieldError{} = value), do: value

  def bra_cpf(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [value],
      reason: "the value must be a string",
      value: value
    }
  end

  def bra_cpf(value) do
    regex = ~r/^(\d{3}\.\d{3}\.\d{3}\-\d{2})$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [value],
        reason: "the value is not a valid CPF",
        value: value
      }
    end
  end
end
