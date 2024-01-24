defmodule Elform.Validations.Strings.Bra.Cnpj do
  alias Elform.SchemaFieldError

  def bra_cnpj(%SchemaFieldError{} = value), do: value

  def bra_cnpj(value) when not is_bitstring(value) do
    %SchemaFieldError{
      arguments: [value],
      reason: "the value must be a string",
      value: value
    }
  end

  def bra_cnpj(value) do
    regex = ~r/^(\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2})$/

    if Regex.match?(regex, value) do
      value
    else
      %SchemaFieldError{
        arguments: [value],
        reason: "the value is not a valid CNPJ",
        value: value
      }
    end
  end
end
